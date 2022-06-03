require './lib/item_repository'
require './lib/item'

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
    description = "You&#39;ve got a total socialmedia iconset! Almost every social icon on the planet earth.\nMore then 510+ icons to use and a BONUS PACK includ
ed (free 85 original UI icons included).\nFacebook, Pinterest, Twitter, Google, Instagram and a lot of unique icons like Zynga, Tinder and much mo
re...\nI provide you a bunch of folders with ready to go transparent PNG in 8 sizes (512px, 256px, 128px, 96px, 64px, 48px, 32px, 24px). The icons
et is made by enjoy and pixel perfection. \n\n\n\n\nFiles:\n\nAI, PSD, CDR, PNG, JPEG, SVG, TTF, EOT, WOFF\n\n\n\n\nWhy should I buy it?\n\n100% v
ector shapes (AI, CDR, SVG)\nimage file (transparent PNG, JPEG, SVG)\nreaty to use web font files (TTF, EOT, WOFF)\neasy to customize vector layer
d PSD\nflat design excellent for any background\nHover & Selected two states\navailable in 8 transparent PNG Sizes\npixel perfect precision\n\n\n\
n\nIcons list:\n\n8tracks\n9gag\n500px\nabout\naddthis\nAIM\nalistapart\nallegro\namazon\nangelList\nAOL\nappstore\nask\naws\nbadoo\nbaidu\nbaseca
mp\nbebo\nbeejive\nbehance\nbigcartel\nbing\nbitbucket\nbitcoin\nbitly\nblablacar\nblip\nbloger\nbloglovin\nblurb\nbooking\nbublews\nbuffer\nchirp
\ncodepen\ncoderwall\ncodeschool\ncoursera\ndeezer\ndelicious\ndesigner news\ndesignfloat\ndeviantart\ndigg\ndisqus\ndribbble\ndropbox\nebay\nello
\nendomondo\nenvato\ne-podroznik\netsy\neventbrite\nevernote\nexfm\nfacebook\nfancy\nfedburner\nfeedly\nfilmweb\nflattr\nflickr\nflipboard\nfolkd\
nfoodspotting\nforrst\nfoursquare\ngetpocket\ngit\ngithub\ngoodreads\ngoogledrive\ngooglepicasa\ngoogleplay\ngoogle+\ngravatar\nhongouts\nheroku\n
hi5\nhouzz\nicq\nimdb\nimgur\ninstagram\njakdojade\njsfiddle\nkickstarter\nkik\nklout\nlaravel\nlast\nlearnist\nletterboxd\nlinkedin\nlivejournal\
nmediatemplate\nmedium\nmendeley\nmicroformats\nmixi\nmobilempk\nmodernizer\nmyspace\nnewsvine\nnk\noffice\noutlook\npath\npheed\nphotobucket\npin
board\npingup\npinterest\nplaystation\nproto\nquora\nrdio\nreadability\nreddit\nrss\nsharebloc\nsharethis\nshopify\nskydrive\nskype\nskyrock\nslas
hdot\nslideshare\nsmashingmagazine\nsnapchat\nsoundcloud\nspotify\nspringme\naquarespace\nstackexchange\nstackoverflow\nsteam\nstumbleupon\nsulia\
ntechnorati\nted\nthumbit\ntinder\ntrapit\ntreehouse\ntrello\ntripadvisor\ntumblr\ntwitch\ntwitter\ntypo3\nuber\nviadeo\nviddler\nvimeo\nvine\nvko
ntakte\nweheartit\nweibo\nwhatsup\nwikipedia\nwordpress\nwrike\nxing\nyahoo\nyelp\nyoutube\nzerply\nzynga"


    expect(@item_repository.find_all_with_description(description).first).to be_a Item
    expect(@item_repository.all.first.id).to eq(263395237)
    expect(@item_repository.find_all_with_description(description)).to be_a Array

  end
end
