require './lib/item_repository'
require './lib/sales_engine'
require 'csv'

RSpec.describe do
  before(:each) do
    @engine = SalesEngine.from_csv({
                                items: './data/items.csv',
                                merchants: './data/merchants.csv'
                              })
    end
  it 'exists' do
    repo = ItemRepository.new('./data/items.csv')
    expect(repo).to be_an_instance_of(ItemRepository)
  end

  # xit 'converts the csv to a hash' do
  #   repo = ItemRepository.new('./data/items.csv')
  #   results = repo.to_hash('./data/items.csv')
  #   expect(results).to be_a(Hash)
  # end

  it 'adds keys to item instances array' do
    # repo = ItemRepository.new('./data/items.csv')
    # repo.to_hash('./data/items.csv')
    expect(@engine.items.all.count).to eq(1367)
  end

  it 'can find an item by id' do
    repo = ItemRepository.new('./data/items.csv')
    item_1 = { '263395237' =>
    { id: '263395237',
      name: '510+ RealPush Icon Set',
      description: "You&#39;ve got a total socialmedia iconset! Almost every social icon on the planet earth.\nMore then 510+ icons to use and a BONUS PACK included (free 85 original UI icons included).\nFacebook, Pinterest, Twitter, Google, Instagram and a lot of unique icons like Zynga, Tinder and much more...\nI provide you a bunch of folders with ready to go transparent PNG in 8 sizes (512px, 256px, 128px, 96px, 64px, 48px, 32px, 24px). The iconset is made by enjoy and pixel perfection.\n\n\n\n\nFiles:\n\nAI, PSD, CDR, PNG, JPEG, SVG, TTF, EOT, WOFF\n\n\n\n\nWhy should I buy it?\n\n100% vector shapes (AI, CDR, SVG)\nimage file (transparent PNG, JPEG, SVG)\nreaty to use web font files (TTF, EOT, WOFF)\neasy to customize vector layerd PSD\nflat design excellent for any background\nHover & Selected two states\navailable in 8 transparent PNG Sizes\npixel perfect precision\n\n\n\n\nIcons list:\n\n8tracks\n9gag\n500px\nabout\naddthis\nAIM\nalistapart\nallegro\namazon\nangelList\nAOL\nappstore\nask\naws\nbadoo\nbaidu\nbasecamp\nbebo\nbeejive\nbehance\nbigcartel\nbing\nbitbucket\nbitcoin\nbitly\nblablacar\nblip\nbloger\nbloglovin\nblurb\nbooking\nbublews\nbuffer\nchirp\ncodepen\ncoderwall\ncodeschool\ncoursera\ndeezer\ndelicious\ndesigner news\ndesignfloat\ndeviantart\ndigg\ndisqus\ndribbble\ndropbox\nebay\nello\nendomondo\nenvato\ne-podroznik\netsy\neventbrite\nevernote\nexfm\nfacebook\nfancy\nfedburner\nfeedly\nfilmweb\nflattr\nflickr\nflipboard\nfolkd\nfoodspotting\nforrst\nfoursquare\ngetpocket\ngit\ngithub\ngoodreads\ngoogledrive\ngooglepicasa\ngoogleplay\ngoogle+\ngravatar\nhongouts\nheroku\nhi5\nhouzz\nicq\nimdb\nimgur\ninstagram\njakdojade\njsfiddle\nkickstarter\nkik\nklout\nlaravel\nlast\nlearnist\nletterboxd\nlinkedin\nlivejournal\nmediatemplate\nmedium\nmendeley\nmicroformats\nmixi\nmobilempk\nmodernizer\nmyspace\nnewsvine\nnk\noffice\noutlook\npath\npheed\nphotobucket\npinboard\npingup\npinterest\nplaystation\nproto\nquora\nrdio\nreadability\nreddit\nrss\nsharebloc\nsharethis\nshopify\nskydrive\nskype\nskyrock\nslashdot\nslideshare\nsmashingmagazine\nsnapchat\nsoundcloud\nspotify\nspringme\naquarespace\nstackexchange\nstackoverflow\nsteam\nstumbleupon\nsulia\ntechnorati\nted\nthumbit\ntinder\ntrapit\ntreehouse\ntrello\ntripadvisor\ntumblr\ntwitch\ntwitter\ntypo3\nuber\nviadeo\nviddler\nvimeo\nvine\nvkontakte\nweheartit\nweibo\nwhatsup\nwikipedia\nwordpress\nwrike\nxing\nyahoo\nyelp\nyoutube\nzerply\nzynga",
      unit_price: '1200',
      merchant_id: '12334141',
      created_at: '2016-01-11 09:34:06 UTC',
      updated_at: '2007-06-04 21:35:10 UTC' } }
    results = repo.find_by_id('263395237')
    expect(results).to eq item_1
  end

  xit 'it can find an item by name' do
    repo = ItemRepository.new('./data/items.csv')
    item_1 = { '263395237' =>
    { id: '263395237',
      name: '510+ RealPush Icon Set',
      description: "You&#39;ve got a total socialmedia iconset! Almost every social icon on the planet earth.\nMore then 510+ icons to use and a BONUS PACK included (free 85 original UI icons included).\nFacebook, Pinterest, Twitter, Google, Instagram and a lot of unique icons like Zynga, Tinder and much more...\nI provide you a bunch of folders with ready to go transparent PNG in 8 sizes (512px, 256px, 128px, 96px, 64px, 48px, 32px, 24px). The iconset is made by enjoy and pixel perfection.\n\n\n\n\nFiles:\n\nAI, PSD, CDR, PNG, JPEG, SVG, TTF, EOT, WOFF\n\n\n\n\nWhy should I buy it?\n\n100% vector shapes (AI, CDR, SVG)\nimage file (transparent PNG, JPEG, SVG)\nreaty to use web font files (TTF, EOT, WOFF)\neasy to customize vector layerd PSD\nflat design excellent for any background\nHover & Selected two states\navailable in 8 transparent PNG Sizes\npixel perfect precision\n\n\n\n\nIcons list:\n\n8tracks\n9gag\n500px\nabout\naddthis\nAIM\nalistapart\nallegro\namazon\nangelList\nAOL\nappstore\nask\naws\nbadoo\nbaidu\nbasecamp\nbebo\nbeejive\nbehance\nbigcartel\nbing\nbitbucket\nbitcoin\nbitly\nblablacar\nblip\nbloger\nbloglovin\nblurb\nbooking\nbublews\nbuffer\nchirp\ncodepen\ncoderwall\ncodeschool\ncoursera\ndeezer\ndelicious\ndesigner news\ndesignfloat\ndeviantart\ndigg\ndisqus\ndribbble\ndropbox\nebay\nello\nendomondo\nenvato\ne-podroznik\netsy\neventbrite\nevernote\nexfm\nfacebook\nfancy\nfedburner\nfeedly\nfilmweb\nflattr\nflickr\nflipboard\nfolkd\nfoodspotting\nforrst\nfoursquare\ngetpocket\ngit\ngithub\ngoodreads\ngoogledrive\ngooglepicasa\ngoogleplay\ngoogle+\ngravatar\nhongouts\nheroku\nhi5\nhouzz\nicq\nimdb\nimgur\ninstagram\njakdojade\njsfiddle\nkickstarter\nkik\nklout\nlaravel\nlast\nlearnist\nletterboxd\nlinkedin\nlivejournal\nmediatemplate\nmedium\nmendeley\nmicroformats\nmixi\nmobilempk\nmodernizer\nmyspace\nnewsvine\nnk\noffice\noutlook\npath\npheed\nphotobucket\npinboard\npingup\npinterest\nplaystation\nproto\nquora\nrdio\nreadability\nreddit\nrss\nsharebloc\nsharethis\nshopify\nskydrive\nskype\nskyrock\nslashdot\nslideshare\nsmashingmagazine\nsnapchat\nsoundcloud\nspotify\nspringme\naquarespace\nstackexchange\nstackoverflow\nsteam\nstumbleupon\nsulia\ntechnorati\nted\nthumbit\ntinder\ntrapit\ntreehouse\ntrello\ntripadvisor\ntumblr\ntwitch\ntwitter\ntypo3\nuber\nviadeo\nviddler\nvimeo\nvine\nvkontakte\nweheartit\nweibo\nwhatsup\nwikipedia\nwordpress\nwrike\nxing\nyahoo\nyelp\nyoutube\nzerply\nzynga",
      unit_price: '1200',
      merchant_id: '12334141',
      created_at: '2016-01-11 09:34:06 UTC',
      updated_at: '2007-06-04 21:35:10 UTC' } }
    results = repo.find_by_name('510+ RealPush Icon Set')
    expect(results).to eq([item_1])
  end
end
