namespace :elasticdpla do

  desc 'reinitialize item index'
  task :initialize_item_index do
    require Rails.root.to_s + '/app/models/record_source.rb'
    require Rails.root.to_s + '/app/models/item.rb'

    Tire.index 'items' do
      delete
      create
    end

    Tire.index 'record_sources' do
      delete
      create
    end
  end

  desc 'import marc21 records'
  task :import_marc21, :file_name, :organization, :limit do |t, args|

    unless File.exist?(args[:file_name].to_s)
      puts 'Please give me a file name'
      exit
    end

    require Rails.root.to_s + '/app/models/record_source.rb'
    require Rails.root.to_s + '/app/models/item.rb'

    
#    marc = MARC::Reader.new('tmp/sample_data/oac_bancroft_lib.mrc')
    marc = MARC::Reader.new(args[:file_name].to_s)

    sourceObj = RecordSource.new
    sourceObj.organization = args[:organization].to_s
    sourceObj.save

    j = 0
    marc.each do |record|
      j = j + 1
      dc_record = nil
      begin
        dc_record = MARC::DublinCore.map(record)
        i = Item.new dc_record
        i.original_record = record
        i.source = sourceObj
        i.save
      rescue Exception => e
        puts "Error importing record"
        puts e.inspect
        puts record.inspect
        puts dc_record.inspect
        puts
        puts
      end
      if j % 100 == 0
        puts "#{j} records imported" 
      end
      if ! args[:limit].nil? && j == args[:limit].to_i
        puts "enough. We're done here"
        exit
      end
    end

  end

end
