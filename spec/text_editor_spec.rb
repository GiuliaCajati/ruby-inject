require './lib/text_editor.rb'

RSpec.describe TextEditor do

  describe 'TextEditor' do
    
    before :each do
      @editor = TextEditor.new
    end
    
    describe '::new' do
      it 'is initialized with an empty buffer, and clipboard' do
        expect(TextEditor.new.buffer.length).to eq(0)
        expect(TextEditor.new.clipboard.length).to eq(0)        
      end
    end

    describe '#perform' do
      context 'given the insert operation,' do
        it 'inserts the string to the buffer, starting at the given index' do
          @editor.perform(:insert, 'Hello', 0)
          expect(@editor.buffer).to eq('Hello')
          @editor.perform(:insert, '!', -1)
          expect(@editor.buffer).to eq('Hello!')
          @editor.perform(:insert, ' world', 5)
          expect(@editor.buffer).to eq('Hello world!')
        end
      end
    end 

      context 'given the cut operation,' do
        it 'removes the characters from the buffet starting at the given index' do
          @editor.buffer = 'Mission Accomplished!'
          @editor.perform(:cut, 3, 4)
          expect(@editor.buffer).to eq('Miss Accomplished!')
          @editor.perform(:cut, 5, 0)
          expect(@editor.buffer).to eq('Accomplished!')
          @editor.perform(:cut, 1, -1)
          expect(@editor.buffer).to eq('Accomplished')
        end
        it 'adds the removed characters to the end of the clipboard' do
          @editor.clipboard = ['Make', 'It', 'Count']
          @editor.buffer = 'Mission Accomplished!'
          @editor.perform(:cut, 3, -5)
          expect(@editor.clipboard[-1]).to eq('she')
          @editor.perform(:cut, 1, 0)
          expect(@editor.clipboard[-1]).to eq('M')
          @editor.perform(:cut, 1, -1)
          expect(@editor.clipboard).to eq(['Make', 'It', 'Count','she','M','!'])
        end
      end

      context 'given the duplicate operation,' do
        it 'adds the buffer at the given index' do
          @editor.clipboard = ['Make', 'It', 'Count']
          @editor.buffer = 'Light The Fuse '
          @editor.perform(:duplicate, 5, 0, -1)
          expect(@editor.buffer).to eq('Light The Fuse Light')
          @editor.perform(:duplicate, 5, -1, 0)
          expect(@editor.buffer).to eq('tLight The Fuse Light')
        end
        it 'adds the copied characters to the end of the clipboard' do
          @editor.buffer = 'Red Light!'
          @editor.clipboard = ['Make', 'It', 'Count']
          @editor.perform(:duplicate, 5, 4, 2)
          expect(@editor.clipboard).to eq(['Make', 'It', 'Count', 'Light'])
          @editor.perform(:duplicate, 1, 4, 2)
          expect(@editor.clipboard).to eq(["Make", "It", "Count", "Light", "g"])
        end
      end

      context 'given the paste operation,' do
        it 'inserts the string, that was last added to the clipboard, on to the buffer at the given index' do
          @editor.buffer = 'The Countdown Is Helping.'
          @editor.clipboard = ['one',' two','three ', 'Not ']
          @editor.perform(:paste, -9)
          expect(@editor.buffer).to eq('The Countdown Is Not Helping.')
          @editor.perform(:paste, 0)
          expect(@editor.buffer).to eq('three The Countdown Is Not Helping.')
          @editor.perform(:paste, 5)
          expect(@editor.buffer).to eq('three two The Countdown Is Not Helping.')
          @editor.perform(:paste, -1)
          expect(@editor.buffer).to eq('three two The Countdown Is Not Helping.one')
        end
        it 'removes the string that was last added to the clipboard' do
          @editor.clipboard = ['one','two','three']
          @editor.perform(:paste, 0)
          expect(@editor.clipboard).to eq(['one','two'])
          @editor.perform(:paste, 5)
          expect(@editor.clipboard).to eq(['one'])
          @editor.perform(:paste, 1)
          expect(@editor.clipboard).to eq([])
        end
      end

  end
end 


