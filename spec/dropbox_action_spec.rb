describe Fastlane::Actions::DropboxAction do
  describe '#run' do
    it 'prints a message' do
      expect(Fastlane::UI).to receive(:message).with("The dropbox plugin is working!")

      Fastlane::Actions::DropboxAction.run(nil)
    end
  end
end
