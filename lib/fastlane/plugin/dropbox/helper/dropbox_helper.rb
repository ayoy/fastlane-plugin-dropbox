module Fastlane
  module Helper
    class DropboxHelper
      # class methods that you define here become available in your action
      # as `Helper::DropboxHelper.your_method`
      #
      def self.show_message
        UI.message("Hello from the dropbox plugin helper!")
      end
    end
  end
end
