require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_engine'
require 'CSV'
require 'pry'

class SalesEngineTest < Minitest::Test
  def test_that_it_exists
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    })
    assert_instance_of SalesEngine, se
  end

  def test_that_it_has_attributes
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    })

    assert_equal "./data/items.csv", se.items_file
    assert_equal "./data/merchants.csv", se.merchants_file
  end

  def test_that_merchant_creates_a_array_of_hashes
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    })
    mr = se.merchants
    expected = {:id=>12334105, :name=>"Shopin1901", :created_at=>"2010-12-10", :updated_at=>"2011-12-04"}
    actual = mr[0]

    assert_equal expected , actual
  end

  def test_that_items_obtains_array_of_item_hashes
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    })
    ir = se.items
    expected = {:id=>263395237,
 :name=>"510+ RealPush Icon Set",
 :description=>
  "You&#39;ve got a total socialmedia iconset! Almost every social icon on the planet earth.\nMore then 510+ icons to use and a BONUS PACK included (free 85 original UI icons included).\nFacebook, Pinterest, Twitter, Google, Instagram and a lot of unique icons like Zynga, Tinder and much more...\nI provide you a bunch of folders with ready to go transparent PNG in 8 sizes (512px, 256px, 128px, 96px, 64px, 48px, 32px, 24px). The iconset is made by enjoy and pixel perfection. \n\n\n\n\nFiles:\n\nAI, PSD, CDR, PNG, JPEG, SVG, TTF, EOT, WOFF\n\n\n\n\nWhy should I buy it?\n\n100% vector shapes (AI, CDR, SVG)\nimage file (transparent PNG, JPEG, SVG)\nreaty to use web font files (TTF, EOT, WOFF)\neasy to customize vector layerd PSD\nflat design excellent for any background\nHover & Selected two states\navailable in 8 transparent PNG Sizes\npixel perfect precision\n\n\n\n\nIcons list:\n\n8tracks\n9gag\n500px\nabout\naddthis\nAIM\nalistapart\nallegro\namazon\nangelList\nAOL\nappstore\nask\naws\nbadoo\nbaidu\nbasecamp\nbebo\nbeejive\nbehance\nbigcartel\nbing\nbitbucket\nbitcoin\nbitly\nblablacar\nblip\nbloger\nbloglovin\nblurb\nbooking\nbublews\nbuffer\nchirp\ncodepen\ncoderwall\ncodeschool\ncoursera\ndeezer\ndelicious\ndesigner news\ndesignfloat\ndeviantart\ndigg\ndisqus\ndribbble\ndropbox\nebay\nello\nendomondo\nenvato\ne-podroznik\netsy\neventbrite\nevernote\nexfm\nfacebook\nfancy\nfedburner\nfeedly\nfilmweb\nflattr\nflickr\nflipboard\nfolkd\nfoodspotting\nforrst\nfoursquare\ngetpocket\ngit\ngithub\ngoodreads\ngoogledrive\ngooglepicasa\ngoogleplay\ngoogle+\ngravatar\nhongouts\nheroku\nhi5\nhouzz\nicq\nimdb\nimgur\ninstagram\njakdojade\njsfiddle\nkickstarter\nkik\nklout\nlaravel\nlast\nlearnist\nletterboxd\nlinkedin\nlivejournal\nmediatemplate\nmedium\nmendeley\nmicroformats\nmixi\nmobilempk\nmodernizer\nmyspace\nnewsvine\nnk\noffice\noutlook\npath\npheed\nphotobucket\npinboard\npingup\npinterest\nplaystation\nproto\nquora\nrdio\nreadability\nreddit\nrss\nsharebloc\nsharethis\nshopify\nskydrive\nskype\nskyrock\nslashdot\nslideshare\nsmashingmagazine\nsnapchat\nsoundcloud\nspotify\nspringme\naquarespace\nstackexchange\nstackoverflow\nsteam\nstumbleupon\nsulia\ntechnorati\nted\nthumbit\ntinder\ntrapit\ntreehouse\ntrello\ntripadvisor\ntumblr\ntwitch\ntwitter\ntypo3\nuber\nviadeo\nviddler\nvimeo\nvine\nvkontakte\nweheartit\nweibo\nwhatsup\nwikipedia\nwordpress\nwrike\nxing\nyahoo\nyelp\nyoutube\nzerply\nzynga",
 :unit_price=>"1200",
 :merchant_id=>"12334141",
 :created_at=>"2016-01-11 09:34:06 UTC",
 :updated_at=>"2007-06-04 21:35:10 UTC"}
    actual = ir[0]

    assert_equal expected , actual
  end
end
