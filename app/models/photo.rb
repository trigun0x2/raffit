class Photo < ActiveRecord::Base
  attr_accessible :file, :item_id

  belongs_to :items

  def self.upload(id, upload)
    name =  "#{Time.now.to_f}"+upload.original_filename
    directory = "public/images"
    path = File.join(directory, name)
    File.open(path, "wb") { |f| f.write(upload.read) }
    @entry = Photo.new(:item_id => id, :file => name)
    @entry.save
  end

  def self.get(*query)
  	photos = Array.new
  	dbp = Photo.find(*query)
  	dbp.each do |photo|
  	  photos.push(photo.file)
  	end
  	return photos
  end

  def self.getByID(id)
  	photos = Array.new
  	dbp = Photo.where(:item_id => id)
  	dbp.each do |photo|
  	  photos.push(photo.file)
  	end
  	return photos
  end

end
