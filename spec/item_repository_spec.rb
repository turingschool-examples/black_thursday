require './lib/item_repository'
require './lib/item'
require 'pry'

RSpec.describe ItemRepository do
  before :each do
      @item_repository = ItemRepository.new('./data/items.csv')
  end

  it 'exists' do
    expect(@item_repository).to be_a ItemRepository
  end

  it "has items" do
    expect(@item_repository.all.first.id).to eq(263395237)
    expect(@item_repository.all.first).to be_instance_of Item
    expect(@item_repository.all).to be_a Array
  end

  it "can find by id" do
    expect(@item_repository.find_by_id(263395237)).to be_a Item
    expect(@item_repository.find_by_id(263395237).name).to eq("510+ RealPush Icon Set")
  end

  it "can find an item by name" do

    expect(@item_repository.find_by_name("510+ RealPush Icon Set")).to be_instance_of Item
  end

  it "can find all items with the same description" do
   description = "- Chunky knit infinity scarf
   - Soft mixture of 97% Acrylic and 3% Viscose
   - Beautiful, Warm, and Stylish
   - Very easy to care for
   
   Hand wash with cold water and lay flat to dry"

    expect(@item_repository.find_all_with_description(description)).to be_a Array
    expect(@item_repository.find_all_with_description(description).first).to be_nil
    
    description_2 =   "You&#39;ve got a total socialmedia iconset! Almost every social icon on the planet earth.\nMore then 510+ icons to use and a BONUS PACK included (free 85 original UI icons included).\nFacebook, Pinterest, Twitter, Google, Instagram and a lot of unique icons like Zynga, Tinder and much more...\nI provide you a bunch of folders with ready to go transparent PNG in 8 sizes (512px, 256px, 128px, 96px, 64px, 48px, 32px, 24px). The iconset is made by enjoy and pixel perfection. \n\n\n\n\nFiles:\n\nAI, PSD, CDR, PNG, JPEG, SVG, TTF, EOT, WOFF\n\n\n\n\nWhy should I buy it?\n\n100% vector shapes (AI, CDR, SVG)\nimage file (transparent PNG, JPEG, SVG)\nreaty to use web font files (TTF, EOT, WOFF)\neasy to customize vector layerd PSD\nflat design excellent for any background\nHover & Selected two states\navailable in 8 transparent PNG Sizes\npixel perfect precision\n\n\n\n\nIcons list:\n\n8tracks\n9gag\n500px\nabout\naddthis\nAIM\nalistapart\nallegro\namazon\nangelList\nAOL\nappstore\nask\naws\nbadoo\nbaidu\nbasecamp\nbebo\nbeejive\nbehance\nbigcartel\nbing\nbitbucket\nbitcoin\nbitly\nblablacar\nblip\nbloger\nbloglovin\nblurb\nbooking\nbublews\nbuffer\nchirp\ncodepen\ncoderwall\ncodeschool\ncoursera\ndeezer\ndelicious\ndesigner news\ndesignfloat\ndeviantart\ndigg\ndisqus\ndribbble\ndropbox\nebay\nello\nendomondo\nenvato\ne-podroznik\netsy\neventbrite\nevernote\nexfm\nfacebook\nfancy\nfedburner\nfeedly\nfilmweb\nflattr\nflickr\nflipboard\nfolkd\nfoodspotting\nforrst\nfoursquare\ngetpocket\ngit\ngithub\ngoodreads\ngoogledrive\ngooglepicasa\ngoogleplay\ngoogle+\ngravatar\nhongouts\nheroku\nhi5\nhouzz\nicq\nimdb\nimgur\ninstagram\njakdojade\njsfiddle\nkickstarter\nkik\nklout\nlaravel\nlast\nlearnist\nletterboxd\nlinkedin\nlivejournal\nmediatemplate\nmedium\nmendeley\nmicroformats\nmixi\nmobilempk\nmodernizer\nmyspace\nnewsvine\nnk\noffice\noutlook\npath\npheed\nphotobucket\npinboard\npingup\npinterest\nplaystation\nproto\nquora\nrdio\nreadability\nreddit\nrss\nsharebloc\nsharethis\nshopify\nskydrive\nskype\nskyrock\nslashdot\nslideshare\nsmashingmagazine\nsnapchat\nsoundcloud\nspotify\nspringme\naquarespace\nstackexchange\nstackoverflow\nsteam\nstumbleupon\nsulia\ntechnorati\nted\nthumbit\ntinder\ntrapit\ntreehouse\ntrello\ntripadvisor\ntumblr\ntwitch\ntwitter\ntypo3\nuber\nviadeo\nviddler\nvimeo\nvine\nvkontakte\nweheartit\nweibo\nwhatsup\nwikipedia\nwordpress\nwrike\nxing\nyahoo\nyelp\nyoutube\nzerply\nzynga"
    
    expect(@item_repository.find_all_with_description(description_2)).to be_a Array
    expect(@item_repository.find_all_with_description(description_2).length).to eq 1
    expect(@item_repository.find_all_with_description(description_2).first.id).to eq 263395237

  end

  it " can find all by price" do
      expect(@item_repository.find_all_by_price(1200)).to be_a Array
      expect(@item_repository.find_all_by_price(1200).length).to eq 41
      expect(@item_repository.find_all_by_price(1200).first.id).to eq 263395237
  end

  it 'is verifing passed in range is within item unit_price range of instantiated items' do
      expect(@item_repository.find_all_by_price_in_range(0..1200)).to be_a Array
      expect(@item_repository.find_all_by_price_in_range(0..1200).length).to eq 350
  end

  it 'can find all by merchant id' do
      expect(@item_repository.find_all_by_merchant_id(12334105).first).to be_a Item 
      expect(@item_repository.find_all_by_merchant_id(12334105).length).to eq 3 
      expect(@item_repository.find_all_by_merchant_id(12334105)).to be_a Array
      expect(@item_repository.find_all_by_merchant_id(00000000).length).to eq 0
  end

  it 'can create a new item_id' do
    expect(@item_repository.new_id)
  end

  it 'can create a new item instance' do
    attributes =   {
        :name => "Candace",
        :description => "Clean Queen Frog",
        :unit_price => 20,
        :created_at => Time.now,
        :updated_at => Time.now,
        :merchant_id => 12334105
  }

     expect(@item_repository.create(attributes)).to be_a Array
     expect(@item_repository.all.last).to be_a Item
     expect(@item_repository.all.last.name).to eq "Candace"
     expect(@item_repository.all.last.id).to eq 263567475
  end



end
