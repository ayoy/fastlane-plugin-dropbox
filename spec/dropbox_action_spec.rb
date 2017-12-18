require 'dropbox_api'

class String
  def name
    File.basename(self)
  end
end

describe Fastlane::Actions::DropboxAction do
  describe '#run' do
    let(:file_path) { '/path/to/file.txt' }
    let(:dropbox_path) { '/dropbox-folder' }
    let(:destination_path) { "#{dropbox_path}/#{File.basename(file_path)}" }
    let(:file_data) { 'file-data' }

    let(:params) do
      {
        file_path: file_path,
        dropbox_path: dropbox_path,
        app_key: 'dropbox-app-key',
        app_secret: 'dropbox-app-secret',
        keychain: '/path/to/keychain',
        keychain_password: 'very-secret-password'
      }
    end

    context 'with valid parameters' do
      before do
        allow(File).to receive(:size)
          .with(params[:file_path])
          .and_return(16_384)
        allow(File).to receive(:read)
          .with(params[:file_path])
          .and_return(file_data)

        allow_any_instance_of(DropboxApi::Client).to receive(:upload)
          .with(destination_path, file_data)
          .and_return(destination_path)
        allow(Fastlane::Actions::DropboxAction).to receive(:get_token_from_keychain)
          .with(params[:keychain], params[:keychain_password])
          .and_return('4CC355-T0K3N')
      end

      it 'should upload a file to dropbox' do
        expect(Fastlane::UI).to receive(:success).with("Successfully uploaded archive to Dropbox at '#{destination_path}'")
        Fastlane::Actions::DropboxAction.run(params)
      end
    end
  end
end
