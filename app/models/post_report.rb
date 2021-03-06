class PostReport < ActiveRecord::Base
  scope :published, lambda { where('published_at IS NOT NULL AND published_at <= ?', Time.zone.now) }
  scope :recent, lambda { published.order(:published_at) }
  scope :guid, lambda {|guid| where(:guid => guid) }
  
  def self.by_slug(params)
    published.where(
      :year => params[:year], :month => params[:month], :day => params[:day], :slug => params[:slug]
    ).first or raise ActiveRecord::RecordNotFound
  end
  
  def self.exists?(guid)
    ! where(:guid => guid).empty?
  end
end