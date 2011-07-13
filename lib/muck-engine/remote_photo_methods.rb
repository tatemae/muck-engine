# Adapted from http://trevorturk.com/2008/12/11/easy-upload-via-url-with-paperclip/
module MuckEngine
  module RemotePhotoMethods
  
    extend ActiveSupport::Concern
  
    included do
      before_validation :download_remote_photo, :if => :photo_url_provided?
      validates_presence_of :photo_remote_url, :if => :photo_url_provided?, :message => I18n.translate('muck.engine.invalid_photo_url')     
    end
    
    attr_accessor :photo_url

    private

      def photo_url_provided?
        !self.photo_url.blank?
      end

      def download_remote_photo
        self.photo = do_download_remote_photo
        self.photo_remote_url = photo_url
      end

      def do_download_remote_photo
        io = open(URI.parse(photo_url))
        def io.original_filename; base_uri.path.split('/').last; end
        io.original_filename.blank? ? nil : io
      #rescue # catch url errors with validations instead of exceptions (Errno::ENOENT, OpenURI::HTTPError, etc...)
      end
  
  end
end