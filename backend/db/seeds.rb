require 'mechanize'
require 'pry'

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# User.destroy_all
# Product.destroy_all
# UserProduct.destroy_all
# Ingredient.destroy_all
# ProductIngredient.destroy_all

# u1 = User.create
# u1.name = "Genevieve"
# u1.save


# @scraped_products = []
@scraped_product = []

def get_basic_info(url, product_obj)
    mechanize = Mechanize.new
    
    begin
        page = mechanize.get(url)
    rescue Mechanize::ResponseCodeError => exception
        if exception
            puts ResponseCodeError
            return exception
        end
    end

    product_obj["name"] = page.search('h1').text
    product_obj["brand"] = page.search('h2').text
    
    get_image(page, product_obj)
end

def get_image(page, product_obj)
    scraped_image = page.search("div[id='main-product'] img").first['src']
    
    if scraped_image.include?("product-img-placeholder")
        product_obj["img_url"] = "/Users/genevieve/Development/mod_5/skincare-tracker/frontend/src/assets/product_image_placeholder.svg"
    else
        product_obj["img_url"] = scraped_image
    end
    product_obj["img_url"]

    get_category(page, product_obj)
end

def get_category(page, product_obj)
    scraped_category = ""
    categories = page.search('.category-badge').text.downcase
    if categories.include? "cleansers"
        scraped_category = "Cleanser"
    elsif categories.include? "moisturizers"
        scraped_category = "Moisturizer"
    elsif categories.include? "masks"
        scraped_category = "Mask"
    elsif categories.include? "sunscreen"
        scraped_category = "Sunscreen"
    elsif categories.include? "treatments"
        scraped_category = "Treatment"
    elsif categories.include? "toners"
        scraped_category = "Toner"
    elsif categories.include? "lip care"
        scraped_category = "Lip Care"
    elsif categories.include? "eye care"
        scraped_category = "Eye Care"
    elsif categories.include? "mists"
        scraped_category = "Mist"
    else
        scraped_category = "Misc"
    end

    product_obj["category"] = scraped_category
    get_ingredients(page, product_obj)
end

def get_ingredients(page, product_obj)
    ingredients_arry = []
    table = page.search('tr')
    table.each do |thingy|
        if thingy.search('td')[2].class != NilClass
            ingredient = thingy.search('td')[2].children.first.text.strip.gsub(/\s+/, " ") 
            if thingy.search('td')[3].text.include?("Comedogenic Rating")
                como_rating = thingy.search('td')[3].children.search('div.badge-label').last.text.delete("Comedogenic Rating (").delete(")")
                ingredients_arry << [ingredient, como_rating]
            else
                ingredients_arry << [ingredient, nil]
            end
        end
    end

    product_obj["ingredients"] = ingredients_arry

    get_sunscreen(product_obj)
end

def get_sunscreen(product_obj)
    scraped_pa = nil
    scraped_spf = nil
    
    product = product_obj["name"]
    
    if product.downcase.include?("spf") || product.include?("pa+")
        scraped_spf = product.downcase.gsub(/\s+/, "")[/spf../]
        if scraped_spf.class != NilClass
            scraped_spf.slice!("spf")
        

            if product.include?(scraped_spf + "+")
                scraped_spf = scraped_spf + "+"
            end
            if product.include?("100")
                scraped_spf = "100"
            end
            scraped_spf
        end

        # Get PA rating        
        if product.downcase.include?("pa++++")
            scraped_pa = "++++"
        elsif product.downcase.include?("pa+++")
            scraped_pa = "+++"
        elsif product.downcase.include?("pa++")
            scraped_pa = "++"
        elsif product.downcase.include?("pa+")
            scraped_pa = "+"
        else
            scraped_pa = nil
        end
        scraped_pa
    end

    product_obj["spf"] = scraped_spf
    product_obj["pa"] = scraped_pa

    add_to_array(product_obj)
end

def add_to_array(product_obj)
    @scraped_product = product_obj
end

def add_to_db(scraped_product)
    # puts "SCRAPED PRODUCTS ARRAY!!!!!!"
    # puts scraped_products_array
    counter = 1
    # scraped_products_array.each do |product|
    product = scraped_product
        # if Product.all.count > 0
            # if Product.find_by(name: product["name"]) != nil
            #     product = product
            # end
        # else
            
            p1 = Product.create
            # temp = product["brand"]
            p1.brand = product["brand"],
            p1.name = product["name"],
            p1.category = product["category"],
            p1.img_url = product["img_url"],
            p1.sunscreen_type = product["sunscreen_type"],
            p1.spf = product["spf"],
            p1.pa = product["pa"],
            
            ## the brand attribute gets overwritten with a string of all the attributes; this fixes it
            p1.brand = nil,
            p1.brand = product["brand"],
            p1.save
            
            
            product["ingredients"].each do |ingredient|
                i1 = Ingredient.find_or_create_by(name: ingredient[0])
                i1["como_rating"] = ingredient[1]
                i1.save

                pi1 = ProductIngredient.create
                pi1["product_id"] = p1.id
                pi1["ingredient_id"] = i1.id
                pi1.save
            end

        # # end
        # puts "============================"
        # puts "#{counter} added to db"
        # puts "============================"
        # counter += 1
    
end

## Links ##
links_0 = [
    "https://www.skincarisma.com/products/3wclinic/collagen-cream/ingredient_list#info-section",
    "https://www.skincarisma.com/products/3wclinic/collagen-white-cream/ingredient_list#info-section",
    "https://www.skincarisma.com/products/3wclinic/fresh-white-mask-sheet/ingredient_list#info-section",
    "https://www.skincarisma.com/products/3wclinic/intense-uv-sunblock-spf50/ingredient_list#info-section",
    "https://www.skincarisma.com/products/3wclinic/intensive-uv-sunblock-cream/ingredient_list#info-section",
    "https://www.skincarisma.com/products/3wclinic/intensive-uv-sunblock-cream-spf50/ingredient_list#info-section",
    "https://www.skincarisma.com/products/3wclinic/intensive-uv-sunblock-cream-spf50-pa/ingredient_list#info-section",
    "https://www.skincarisma.com/products/3wclinic/multi-protection-uv-sunblock/ingredient_list#info-section",
    "https://www.skincarisma.com/products/3wclinic/snail-foam-wash/ingredient_list#info-section",
    "https://www.skincarisma.com/products/3wclinic/snail-mucus-sleeping-pack/ingredient_list#info-section",
    "https://www.skincarisma.com/products/3wclinic/uv-snail-day-sun-cream-spf50-pa/ingredient_list#info-section",
    "https://www.skincarisma.com/products/3wclinic/vitamin-c-foam-cleansing/ingredient_list#info-section",
    "https://www.skincarisma.com/products/3wclinic/water-sleeping-pack/ingredient_list#info-section",
    "https://www.skincarisma.com/products/40-carrots/carrot-c-vitamin-serum/ingredient_list#info-section",
    "https://www.skincarisma.com/products/40-carrots/carrot-c-vitamin-serum-b53213cf-8318-42fd-adcc-c1960edd0a1f/ingredient_list#info-section",
    "https://www.skincarisma.com/products/40-carrots/carrot-creme-cleanser/ingredient_list#info-section",
    "https://www.skincarisma.com/products/40-carrots/carrot-cucumber-eye-gel/ingredient_list#info-section",
    "https://www.skincarisma.com/products/40-carrots/carrot-mango-moisture-splurge/ingredient_list#info-section",
    "https://www.skincarisma.com/products/5yina/divine-bio-adaptive-cleanser/ingredient_list#info-section",
    "https://www.skincarisma.com/products/7seven-haircare/borato-volume-shampoo/ingredient_list#info-section",
    "https://www.skincarisma.com/products/7th-heaven/coconut-clay-peel-off/ingredient_list#info-section",
    "https://www.skincarisma.com/products/8-faces/boundless-solid-oil/ingredient_list#info-section",
    "https://www.skincarisma.com/products/9cc/sea-collagen-heben-mask/ingredient_list#info-section",
    "https://www.skincarisma.com/products/9wishes/hydra-perfect-ampoule-serum/ingredient_list#info-section",
    "https://www.skincarisma.com/products/9wishes/perfect-ampoule-serum-oxygen/ingredient_list#info-section",
    "https://www.skincarisma.com/products/9wishes/perfect-ampule-serum-calm/ingredient_list#info-section",
    "https://www.skincarisma.com/products/9wishes/ph5-5-balance-wash/ingredient_list#info-section",
    "https://www.skincarisma.com/products/9wishes/rice-foaming-cleanser/ingredient_list#info-section",
    "https://www.skincarisma.com/products/9wishes/rice-powder-polish/ingredient_list#info-section",
    "https://www.skincarisma.com/products/9wishes/rose-hydrating-capsule-treatment/ingredient_list#info-section",
    "https://www.skincarisma.com/products/9wishes/vanishing-balm-glow/ingredient_list#info-section",
    "https://www.skincarisma.com/products/9wishes/vitamin-healthy-balancing/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-by-bom-cosmetics/all-in-1-ultra-perfect-cream-mask/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-by-bom-cosmetics/blue-cica-boosting-ampoule/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-by-bom-cosmetics/ultra-botanic-skin-water/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-by-bom-cosmetics/ultra-floral-2/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-by-bom-cosmetics/ultra-floral-leaf-mask/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-by-bom-cosmetics/ultra-moisture-black-tea-cream/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-by-bom-cosmetics/ultra-time-return-eye-cream/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-by-bom-cosmetics/ultra-time-return-eye-serum/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-by-bom-cosmetics/ultra-watery-eoseongcho-cleanser/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-d/ointment-d0394f56-ae49-42b6-b420-419abfce1aad/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-derma/dermalibour-foaming-gel/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-derma/dermatological-bar/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-derma/emollient-balm-extra-rich/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-derma/epitheliale-a-h-duo-ultra-repairing-cream-f3937680-5cb1-45f6-9e36-5b0ab9b09002/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-derma/exomega-control-emollient-foaming-gel/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-derma/hydralba-24h-light-hydrating-cream/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-derma/hydralba-uv-light-hydrating-cream/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-derma/nutritive-cream-xera-mega-confort/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-derma/phys-ac-purifying-foaming-gel/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-derma/protect-ac-spf-50/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-derma/protect-ad-spf-50/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-derma/protect-spf-50-invisible-fluid/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-derma/protect-spf-50-very-high-protection-fluid/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-derma/protect-sunspray/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-derma/rheacalm-light-soothing-cream/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-derma/rheacalm-rich-soothing-cream/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-derma/soothing-foaming-gel/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-h-c/hydra-soother-mask/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-h-c/premium-hydra-b5-soothing-foam/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-h-c/premium-phyto-complex-mask/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-h-c/premium-real-eye-cream-for-face/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-h-c/private-real-eye-cream-for-face/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-h-c/real-synergy-ampoule/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-h-c/the-pure-real-eye-cream-for-face/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-h-c/ultimate-real-eye-cream-for-face/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-kin/age-defy-firming-night-cream/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-kin/age-defy-lifting-eye-cream/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-kin/brightening-rosehip-oil-with-vitamin-c/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-kin/cleansing-micellar-water/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-kin/colour-protection-ylang-ylang-quinoa-shampoo/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-kin/correcting-eye-gel/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-kin/hydrating-mist-toner-8b61177b-6ef8-478d-87b2-15d18a024468/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-kin/intense-hydration-day-night-cream/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-kin/moisture-rich-lavender-anthyllis-leave-in-conditioner/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-kin/purifying-gel-cleanser/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-kin/rose-de-mai-anti-oxidant-day-cream/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-kin/white-tea-aloe-vital-hydration-gel-creme/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-love-story/delete-history/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-passion-for-natural/aloe-vera-gel-bec6e3d6-acfc-4638-8422-0851170ee8a2/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/air-fit-cushion-pposong/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/apple-acid-visible-peeling-gel/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/aqua-marine-mineral-cream/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/aqua-marine-mineral-eye-stick/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/aqua-marine-mineral-skin/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/aqua-nature-deep-sea-dewdrop-clearing-softner/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/aqua-nature-dew-drop-clouding-cream/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/aqua-nature-dew-drop-lotion/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/aqua-nature-rose-dewdrop-brightening-toner/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/aqua-peeling-aha-toner/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/aqua-up-clouding-cream/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/baby-tone-up-cream/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/bad-vita-cream/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/banana-milk-sheet-mask-nourishing/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/base-maker-bboyan/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/base-maker-glow/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/base-maker-green/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/base-maker-pink/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/bb-maker-cover-end/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/bb-maker-long-wear/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/bb-maker-moisture/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/bonding-balm-concealer-linen/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/bonding-balm-concealer-mocha/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/bonding-drops-concealer-mocha/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/bonding-skinny-concealer-mocha/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/carrot-u/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/chia-seed-aqua-cream/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/chocolate-milk-sheet-mask-smoothing/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/cica-clear-spot-patch/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/cicative-boosting-toner/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/cicative-calcium-cream/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/cicative-calcium-sheet-mask/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/cicative-magnesium-cream/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/cicative-magnesium-sheet-mask/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/cicative-zinc-cream/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/cicative-zinc-sheet-mask-0058d415-03cb-455a-975d-786279bf339b/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/cicative-zinc-sun-cream/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/clean-scalp-doctor-swab/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/click-pen-shadow-be02/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/coconut-milk-sheet-mask-moisturizing/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/coffee-milk-sheet-mask-firming/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/color-lock-eye-primer/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/color-lock-lip-topcoat/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/color-longwear-shadow-stick-cr01/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/color-longwear-shadow-stick-pk01/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/cotton-lip-fluid/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/creamy-butter-shadow/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/daily-pure-block-natural-sun-cream-spf-45/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/daily-sheet-mask-green-tea/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/deep-clean-cleansing-oil/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/deep-clean-clear-water/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/deep-clean-foam-bubble-foam/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/deep-clean-foam-cleanser/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/deep-clean-foam-cleanser-whipping/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/deep-clean-milky-cleanser/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/dot-spot-v-patch/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/easy-clean-camo-cream/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/enzyme-powder-wash-ad5aeb8a-701a-48fe-9c5f-905c3d2bf0d7/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/essential-source-micro-essence-never-dry/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/essential-source-micro-essence-pure-bright/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/essential-source-micro-foil-mask-pure-bright/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/everyday-sun-gel/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/everyday-suncare/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/fresh-mate-basil-mask-hydrating/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/fresh-mate-milk-mask-brightening/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/fresh-mate-tee-trea-mask-calming/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/fruit-vinegar-sheet-mask-lemon/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/glycolic-acid-cream/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/glycolic-acid-peeling-booster/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/gogo-stick-cheek-cr02/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/gogo-stick-concealer/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/gogo-stick-lip-cr02/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/gogo-stick-shadow-mbr01/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/gogo-stick-shadow-sbe01/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/good-morning-sorbet-mask/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/good-night-water-sleeping-mask/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/grapefruit-sparkling-sheet-mask/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/green-tea-milk-sheet-mask-soothing/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/green-tea-moisture-cream-18417b77-913a-46e3-9e26-efce8a2134eb/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/half-half-color-stick/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/hamamelis-cream/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/hamamelis-sheet-mask/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/hamamelis-t-zone-serum/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/haute-cushion/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/honey-milk-lip-sleeping-pack/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/hyaluthione-essence-toner/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/hyaluthione-soonsoo-ampoule/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/hyaluthione-soonsoo-cream/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/hyaluthione-soonsoo-daily-sheet-mask/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/hyaluthione-soonsoo-essence-toner/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/icing-sweet-bar-sheet-mask-hanrabong/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/icing-sweet-bar-sheet-mask-melon/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/icing-sweet-bar-sheet-mask-pineapple/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/icing-sweet-bar-sheet-mask-watermelon/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/juicy-pang-jelly-blusher-be02/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/juicy-pang-tint-be01/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/juicy-pang-tint-rd01/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/kissable-tint-balm/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/kissable-tint-balm-rd01/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/lip-therapy-essential-tea/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/madecassoside-ampoule/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/madecassoside-cica-balm/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/madecassoside-cica-gel/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/madecassoside-cleansing-foam/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/madecassoside-cream/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/madecassoside-fluid/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/madecassoside-gauze-mask/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/madecassoside-lip-sleeping-mask/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/madecassoside-needle-spot-patch/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/madecassoside-powder-pact/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/madecassoside-soothing-balm/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/madecassoside-stick-foundation/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/madecassoside-sun-cream-spf-39-pa/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/marymond-pastel-blusher-collection-no-1-dear-magnolia/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/matte-sharp-liner-lamuqe-edition/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/messy-hair-essence-tissue/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/milky-u/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/moist-creamy-concealer-spf30-pa/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/moist-creamy-concealer-stick/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/moist-seaberry-2-cleansing-foam/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/multi-correcting-concealer/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/multiple-correcting-stick/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/my-skin-fit-sheet-mask-baobab-tree/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/my-skin-fit-sheet-mask-broccoli/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/my-skin-fit-sheet-mask-honey/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/my-skin-fit-sheet-mask-olive/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/my-skin-fit-sheet-mask-quinoa/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/my-skin-fit-sheet-mask-rose/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/my-skin-fit-sheet-mask-sea-buckthorn/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/naked-peeling-gel-pha/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/no-poreblem-cover-stick/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/nonco-mastic-balancing-moisturizer/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/nonco-mastic-band-patch/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/nonco-mastic-calming-cream/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/nonco-mastic-purifying-toner/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/nonco-mastic-relaxing-gel-foam/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/nonco-mastic-spot-control-serum/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/nonco-mastic-spot-serum-and-concealer-duo/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/nonco-tea-tree-cleansing-foam/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/nonco-tea-tree-sleeping-gel-4de42d14-6538-4e0c-9ac3-5e2d2e5c66ea/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/nonco-tea-tree-stick/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/panthenol-ato-cream/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/peach-yogurt-sheet-mask/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/personal-tone-concealer-palette/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/personal-tone-foundation/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/ph-balancing-18-first-toner/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/ph-balancing-18-fresh-cream/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/ph-balancing-18-moisture-cream/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/power-block-all-day-sun-stick/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/power-block-all-day-sun-stick-pposong/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/power-block-aqua-sun-gel-spf50-pa/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/power-block-daily-sun-cream/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/power-block-essence-sun-cream-spf-50-pa/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/power-block-essence-sun-cream-spf50-pa/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/power-block-pposong-sun-cream/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/power-block-tone-up-sun-base-pink/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/power-block-tone-up-sun-cushion/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/pure-block-aqua-sun-gel/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/pure-block-daily-sun-cream/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/pure-block-mild-plus-sun-cream/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/pure-block-natural-waterproof-sun-cream-spf50-pa/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/pure-block-tone-up-sun-base/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/pure-block-water-bling-sun-balm/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/pure-block-water-bling-sun-balm-spf50-pa/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/pure-medic-intense-cream/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/pure-milk-sheet-mask-hydrating/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/puremedic-daily-facial-cleanser/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/raspberry-hair-vinegar/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/real-big-yogurt-one-bottle-mask-pack-apple/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/real-big-yogurt-one-bottle-mask-pack-plain/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/real-big-yogurt-one-bottle-mask-pack-strawberry/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/redness-tone-up-cream/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/sea-buckthorn-cream/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/shredded-cabbage-gel-cream/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/skin-fit-sheet-mask-baobab-tree/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/skin-fit-sheet-mask-rose/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/slice-cucumber-sheet-mask/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/so-fast-treatment-clinic/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/soo-boo-ji-sun-cotton-spf50-pa/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/soobooji-cushion/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/soobooji-finish-cream/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/soobooji-foundation/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/soobooji-smoothing-primer/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/soobooji-start-toner/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/soobooji-sun-cotton/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/start-up-aqua-primer/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/start-up-cushion-primer/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/start-up-pore-primer/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/startup-matt-primer/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/startup-moisture-primer/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/startup-nude-primer/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/steam-eye-mask/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/stone-peach-pore-less-holding-cream/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/stone-peach-pore-less-tightener/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/strawberry-milk-sheet-mask-brightening/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/super-acai-hair-oil/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/super-moringa-hair-oil/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/super-moringa-hair-oil-mask/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/super-protein-hair-essence-wave-curl/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/super-protein-repairing-shampoo/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/sweet-canola-honey-house-mask/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/thermal-water-cream/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/vitamin-ac-pad/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/vitamin-c-80-mask-kit/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/wasabiya-lip-plumper/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/water-light-tint/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/water-light-tint-rd04/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/waterful-aloe-soothing-gel/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/waterful-bamboo-soothing-gel/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/white-up-clouding-cream/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/wonder-tension-pact-ampoule/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/wonder-tension-pact-corrector-green/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/wonder-tension-pact-corrector-lavender/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/wonder-tension-pact-corrector-pink/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/wonder-tension-pact-madecassoside/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/wonder-tension-pact-moist/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/wonder-tension-pact-perfect-cover/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-pieu/wonder-tension-pact-pposong/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-rin/10-absolute-renewal-serum/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-t-fox/gyoolpy-tea-fresh-water/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-t-fox/tea-cell-energy-ampoule/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-t-fox/tea-cell-soothing-ampoule/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-t-fox/tea-toc-water-boosting-water/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-t-fox/tea-toc-water-cream/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-true/honey-lemon-black-tea-mist/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-true/pure-balancing-cleansing-oil/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-true/real-black-tea-true-active-essence/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-true/spring-green-tea-watery-calming-cream-6773df63-d934-4752-a3e0-6b36ea712740/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a-true/sweet-song-black-tea-energy-cleansing-gel/ingredient_list#info-section",
    "https://www.skincarisma.com/products/a2o-lab/facial-mask-anti-aging/ingredient_list#info-section",
    "https://www.skincarisma.com/products/aa-cosmetics/lumi/ingredient_list#info-section",
    "https://www.skincarisma.com/products/aa-cosmetics/seboregulating-face-cleansing-gel/ingredient_list#info-section",
    "https://www.skincarisma.com/products/abba/gentle-conditioner/ingredient_list#info-section",
    "https://www.skincarisma.com/products/abba/gentle-shampoo-86b28d22-86d3-438a-8460-35d7c45d816f/ingredient_list#info-section",
    "https://www.skincarisma.com/products/abib/facial-soap-black-brick/ingredient_list#info-section",
    "https://www.skincarisma.com/products/abib/facial-soap-grey-brick/ingredient_list#info-section",
    "https://www.skincarisma.com/products/abib/facial-soap-ivory-brick/ingredient_list#info-section",
    "https://www.skincarisma.com/products/abib/facial-soap-pink-brick/ingredient_list#info-section",
    "https://www.skincarisma.com/products/abib/gummy-sheet-mask-heartleaf-sticker/ingredient_list#info-section",
    "https://www.skincarisma.com/products/abib/gummy-sheet-mask-madeca-sticker/ingredient_list#info-section",
    "https://www.skincarisma.com/products/abib/gummy-sheet-mask-milk-sticker/ingredient_list#info-section",
    "https://www.skincarisma.com/products/abib/heartleaf-essence-calming-pump/ingredient_list#info-section",
    "https://www.skincarisma.com/products/abib/hydration-creme-water-tube/ingredient_list#info-section",
    "https://www.skincarisma.com/products/abib/hydration-gel-water-tube/ingredient_list#info-section",
    "https://www.skincarisma.com/products/abib/hydroderma-sp1-2gf-serum/ingredient_list#info-section",
    "https://www.skincarisma.com/products/abib/hypoderma-sp1-2gf-serum-cell-repair/ingredient_list#info-section",
    "https://www.skincarisma.com/products/abib/quick-sunstick-protection-bar-spf50-pa/ingredient_list#info-section",
    "https://www.skincarisma.com/products/abib/vanilla-bean-curl-detangling-milk/ingredient_list#info-section",
    "https://www.skincarisma.com/products/about-me/essential-snail-mucus-mask-sheet/ingredient_list#info-section",
    "https://www.skincarisma.com/products/about-me/skin-tone-up-massage-cream-150ml/ingredient_list#info-section",
    "https://www.skincarisma.com/products/about-me/skin-tone-up-watery-cream/ingredient_list#info-section",
    "https://www.skincarisma.com/products/absolute-new-york/hd-flawless-cushion-foundation/ingredient_list#info-section",
    "https://www.skincarisma.com/products/absolutely-natural/spf-15-broad-spectrum-unv-uvb/ingredient_list#info-section",
    "https://www.skincarisma.com/products/absolution/la-cure-peau-nette/ingredient_list#info-section",
    "https://www.skincarisma.com/products/absolution/le-booster-purete/ingredient_list#info-section",
    "https://www.skincarisma.com/products/absolution/le-serum-anti-soif/ingredient_list#info-section",
    "https://www.skincarisma.com/products/academie/shine-control-gel/ingredient_list#info-section",
    "https://www.skincarisma.com/products/acm/depiwhite-body-milk-whitening-body-milk/ingredient_list#info-section",
    "https://www.skincarisma.com/products/acm/sebionex-trio/ingredient_list#info-section",
    "https://www.skincarisma.com/products/acne-barrier/medicated-protect-gel-cream/ingredient_list#info-section",
    "https://www.skincarisma.com/products/acne-barrier/medicated-protect-lotion/ingredient_list#info-section",
    "https://www.skincarisma.com/products/acne-barrier/medicated-protect-makeup-clear-n/ingredient_list#info-section",
    "https://www.skincarisma.com/products/acne-barrier/medicated-protect-spots/ingredient_list#info-section",
    "https://www.skincarisma.com/products/acne-barrier/medicated-protect-wash/ingredient_list#info-section",
    "https://www.skincarisma.com/products/acne-barrier/medicated-protection-aha-soap-bar-80g/ingredient_list#info-section",
    "https://www.skincarisma.com/products/acne-org/aha/ingredient_list#info-section",
    "https://www.skincarisma.com/products/acne-org/cleanser/ingredient_list#info-section",
    "https://www.skincarisma.com/products/acne-org/jojoba-oil/ingredient_list#info-section",
    "https://www.skincarisma.com/products/acne-org/moisturizer-232595cb-5ea5-445f-8f55-e0470dc2cea3/ingredient_list#info-section",
    "https://www.skincarisma.com/products/acne-org/treatment/ingredient_list#info-section",
    "https://www.skincarisma.com/products/acne-org/treatment-2-5-benzoyl-peroxide/ingredient_list#info-section",
    "https://www.skincarisma.com/products/acnecare/acne-care-drying-lotion/ingredient_list#info-section",
    "https://www.skincarisma.com/products/acnecare/drying-lotion-99edd46a-fd39-44f6-bcb4-51c582365670/ingredient_list#info-section",
    "https://www.skincarisma.com/products/acnefree/2-in-1-acne-wipes-oil-free/ingredient_list#info-section",
    "https://www.skincarisma.com/products/acnefree/acne-astringent-toner-pads-2-in-1-dual-action/ingredient_list#info-section",
    "https://www.skincarisma.com/products/acnefree/acne-spot-treatment-redness-control-original-strength-terminator/ingredient_list#info-section",
    "https://www.skincarisma.com/products/acnefree/body-clearing-acne-spray/ingredient_list#info-section",
    "https://www.skincarisma.com/products/acnefree/daily-skin-therapy-acne-pads/ingredient_list#info-section",
    "https://www.skincarisma.com/products/acnefree/daily-skin-therapy-acne-wash/ingredient_list#info-section",
    "https://www.skincarisma.com/products/acnefree/daily-skin-therapy-complexion-perfecting-cream/ingredient_list#info-section",
    "https://www.skincarisma.com/products/acnefree/oatmeal-jojoba-gentle-acne-scrub/ingredient_list#info-section",
    "https://www.skincarisma.com/products/acnefree/oil-free-acne-cleanser/ingredient_list#info-section",
    "https://www.skincarisma.com/products/acnefree/oil-free-acne-cleanser-08293c9e-4a63-4c67-b6ec-ae2dccaadc49/ingredient_list#info-section",
    "https://www.skincarisma.com/products/acnefree/terminator-10-acne-spot-treatment-redness-control/ingredient_list#info-section",
    "https://www.skincarisma.com/products/acnefree/therapeutic-sulfur-mask/ingredient_list#info-section",
    "https://www.skincarisma.com/products/acnefree/witch-hazel-mattifying-toner/ingredient_list#info-section",
    "https://www.skincarisma.com/products/acnes/derma-relief-moisture-foam-cleanser/ingredient_list#info-section",
    "https://www.skincarisma.com/products/acnes/sealing-jell/ingredient_list#info-section",
    "https://www.skincarisma.com/products/acnevir/adult-acne-redness-relief-gel/ingredient_list#info-section",
    "https://www.skincarisma.com/products/acnol/gel-for-acne/ingredient_list#info-section",
    "https://www.skincarisma.com/products/acnol/lotion-for-acne/ingredient_list#info-section",
    "https://www.skincarisma.com/products/acnomel/adult-acne-medication/ingredient_list#info-section",
    "https://www.skincarisma.com/products/aco/canoderm-5-krem-karbamid/ingredient_list#info-section",
    "https://www.skincarisma.com/products/aco/caring-face-cream/ingredient_list#info-section",
    "https://www.skincarisma.com/products/aco/face-3-in-1-cleansing-milk/ingredient_list#info-section",
    "https://www.skincarisma.com/products/aco/face-day-moisturising-day-cream/ingredient_list#info-section",
    "https://www.skincarisma.com/products/aco/face-refreshing-cleansing-lotion/ingredient_list#info-section",
    "https://www.skincarisma.com/products/aco/lip-cerat/ingredient_list#info-section",
    "https://www.skincarisma.com/products/aco/rebalancing-cleansing-foam/ingredient_list#info-section",
    "https://www.skincarisma.com/products/aco/renewing-face-oil/ingredient_list#info-section",
    "https://www.skincarisma.com/products/aco/spotless-blemish-treating-moisturiser/ingredient_list#info-section",
    "https://www.skincarisma.com/products/aco/spotless-oil-free-matifying-daily-moisturiser/ingredient_list#info-section",
    "https://www.skincarisma.com/products/aco/spotless-overnight-spot-treatment/ingredient_list#info-section",
    "https://www.skincarisma.com/products/aco/sun-face-cream-intensive-moisture-spf20/ingredient_list#info-section",
    "https://www.skincarisma.com/products/aco/sun-face-cream-spf50/ingredient_list#info-section",
    "https://www.skincarisma.com/products/aco/sun-lip-balm-moisturising-spf-30/ingredient_list#info-section",
    "https://www.skincarisma.com/products/aco/sun-stick-spf50/ingredient_list#info-section",
    "https://www.skincarisma.com/products/acqua-alle-rose/distillata-alle-rose-tonico-rinfrescante/ingredient_list#info-section",
    "https://www.skincarisma.com/products/acqua-di-parma/spray-body-lotion-arancia-di-capri/ingredient_list#info-section",
    "https://www.skincarisma.com/products/acqua-di-parma/spray-body-lotion-bergamotto-di-calabria/ingredient_list#info-section",
    "https://www.skincarisma.com/products/acqua-di-parma/spray-body-lotion-chinotto-di-liguria/ingredient_list#info-section",
    "https://www.skincarisma.com/products/acqua-di-parma/spray-body-lotion-fico-di-amalfi/ingredient_list#info-section",
    "https://www.skincarisma.com/products/acqua-di-parma/spray-body-lotion-mirto-di-panarea/ingredient_list#info-section",
    "https://www.skincarisma.com/products/acseine/moist-balance-lotion/ingredient_list#info-section",
    "https://www.skincarisma.com/products/acure-organics/argan-cell-stimulating-body-wash/ingredient_list#info-section",
    "https://www.skincarisma.com/products/acure-organics/argan-cleansing-towelettes/ingredient_list#info-section",
    "https://www.skincarisma.com/products/acure-organics/argan-oil-100-certified-organic/ingredient_list#info-section",
    "https://www.skincarisma.com/products/acure-organics/argan-stem-cell-chlorella-growth-factor-brightening-facial-scrub/ingredient_list#info-section",
    "https://www.skincarisma.com/products/acure-organics/charcoal-face-wash/ingredient_list#info-section",
    "https://www.skincarisma.com/products/acure-organics/citrus-ginger-argan-oil/ingredient_list#info-section",
    "https://www.skincarisma.com/products/acure-organics/coconut-argan-oil/ingredient_list#info-section",
    "https://www.skincarisma.com/products/acure-organics/day-cream-gotu-kola-stem-cell-1-chlorella-growth-factor/ingredient_list#info-section",
    "https://www.skincarisma.com/products/acure-organics/eye-cream-chlorella-edelweiss-stem-cell/ingredient_list#info-section",
    "https://www.skincarisma.com/products/acure-organics/facial-cleansing-creme-argan-oil-mint/ingredient_list#info-section",
    "https://www.skincarisma.com/products/acure-organics/facial-marula-oil/ingredient_list#info-section",
    "https://www.skincarisma.com/products/acure-organics/facial-toner-balancing-rose-red-tea/ingredient_list#info-section",
    "https://www.skincarisma.com/products/acure-organics/incredibly-clear-cleansing-stick/ingredient_list#info-section",
    "https://www.skincarisma.com/products/acure-organics/lemongrass-moroccan-argan-oil-firming-body-lotion/ingredient_list#info-section",
    "https://www.skincarisma.com/products/acure-organics/night-cream-argan-stem-cell-2-chlorella-growth-factor/ingredient_list#info-section",
    "https://www.skincarisma.com/products/acure-organics/oil-control-facial-moisturizer/ingredient_list#info-section",
    "https://www.skincarisma.com/products/acure-organics/radically-rejuvenating-cleansing-cream/ingredient_list#info-section",
    "https://www.skincarisma.com/products/acure-organics/radically-rejuvenating-eye-cream/ingredient_list#info-section",
    "https://www.skincarisma.com/products/acure-organics/radically-rejuvenating-face-mask/ingredient_list#info-section",
    "https://www.skincarisma.com/products/acure-organics/radically-rejuvenating-facial-scrub-e722ee1e-f056-456b-8f18-2aa8bbd4f6f7/ingredient_list#info-section",
    "https://www.skincarisma.com/products/acure-organics/radically-rejuvenating-facial-toner/ingredient_list#info-section",
    "https://www.skincarisma.com/products/acure-organics/radically-rejuvenating-oil-free-serum/ingredient_list#info-section",
    "https://www.skincarisma.com/products/acure-organics/radically-rejuvenating-resurfacing-cream/ingredient_list#info-section",
    "https://www.skincarisma.com/products/acure-organics/radically-rejuvenating-rose-argan-oil/ingredient_list#info-section",
    "https://www.skincarisma.com/products/acure-organics/radically-rejuvenating-vegetable-peel/ingredient_list#info-section",
    "https://www.skincarisma.com/products/acure-organics/sensitive-facial-cleanser-argan-oil-probiotic/ingredient_list#info-section",
    "https://www.skincarisma.com/products/acure-organics/seriously-firming-facial-serum/ingredient_list#info-section",
    "https://www.skincarisma.com/products/acure-organics/seriously-glowing-facial-serum/ingredient_list#info-section",
    "https://www.skincarisma.com/products/acure-organics/seriously-soothing-blue-tansy-night-oil/ingredient_list#info-section",
    "https://www.skincarisma.com/products/acure-organics/seriously-soothing-cleansing-cream/ingredient_list#info-section",
    "https://www.skincarisma.com/products/acure-organics/seriously-soothing-micellar-water-towelettes/ingredient_list#info-section",
    "https://www.skincarisma.com/products/acure-organics/ultra-hydrating-body-lotion/ingredient_list#info-section",
    "https://www.skincarisma.com/products/acure/acne-spot-treatment-maximum-strength/ingredient_list#info-section",
    "https://www.skincarisma.com/products/acure/brightening-cleansing-gel/ingredient_list#info-section",
    "https://www.skincarisma.com/products/acure/brightening-day-cream-4ebd36a1-f747-4bf1-aaba-8e8c18da62ab/ingredient_list#info-section",
    "https://www.skincarisma.com/products/acure/brightening-face-mask/ingredient_list#info-section",
    "https://www.skincarisma.com/products/acure/brightening-facial-scrub-5d2f1de6-0df7-4401-97da-5c925aab2ef8/ingredient_list#info-section",
    "https://www.skincarisma.com/products/acure/brightening-glowing-serum/ingredient_list#info-section",
    "https://www.skincarisma.com/products/acure/brightening-night-cream-bedf00f4-6c20-41e0-a96e-e6e837cfc3bd/ingredient_list#info-section",
    "https://www.skincarisma.com/products/acure/brightening-super-greens-serum/ingredient_list#info-section",
    "https://www.skincarisma.com/products/acure/brilliantly-brightening-eye-contour-gel/ingredient_list#info-section",
    "https://www.skincarisma.com/products/acure/curiously-clarifying-lemongrass-argan/ingredient_list#info-section",
    "https://www.skincarisma.com/products/acure/foil-time-fortifying-silver-foil-mask/ingredient_list#info-section",
    "https://www.skincarisma.com/products/acure/incredibly-clear-charcoal-lemonade-cleansing-clay/ingredient_list#info-section",
    "https://www.skincarisma.com/products/acure/incredibly-clear-charcoal-lemonade-facial-scrub/ingredient_list#info-section",
    "https://www.skincarisma.com/products/acure/incredibly-clear-mattifying-moisturizer/ingredient_list#info-section",
    "https://www.skincarisma.com/products/acure/pore-clarifying-facial-scrub/ingredient_list#info-section",
    "https://www.skincarisma.com/products/acure/radically-rejuvenating-serum-stick/ingredient_list#info-section",
    "https://www.skincarisma.com/products/acure/radically-rejuvenating-spf-day-cream/ingredient_list#info-section",
    "https://www.skincarisma.com/products/acure/radically-rejuvenating-whipped-night-cream/ingredient_list#info-section",
    "https://www.skincarisma.com/products/acure/seriously-soothing-cloud-cream/ingredient_list#info-section",
    "https://www.skincarisma.com/products/acure/seriously-soothing-eye-serum-stick/ingredient_list#info-section",
    "https://www.skincarisma.com/products/acure/seriously-soothing-spf-30-day-cream/ingredient_list#info-section",
    "https://www.skincarisma.com/products/acure/simply-soothing-conditioner-coconut-marula-oil/ingredient_list#info-section",
    "https://www.skincarisma.com/products/acure/the-essentials-rosehip-oil/ingredient_list#info-section",
    "https://www.skincarisma.com/products/acwell/anti-mark-gel-cream/ingredient_list#info-section",
    "https://www.skincarisma.com/products/acwell/aqua-capsule-sun-control-gel/ingredient_list#info-section",
    "https://www.skincarisma.com/products/acwell/aqua-clinity-cream/ingredient_list#info-section",
    "https://www.skincarisma.com/products/acwell/aqua-clinity-cream-double-moisture/ingredient_list#info-section",
    "https://www.skincarisma.com/products/acwell/betaglution-ultra-moisture-toner/ingredient_list#info-section",
    "https://www.skincarisma.com/products/acwell/bubble-free-ph-balancing-cleanser/ingredient_list#info-section",
    "https://www.skincarisma.com/products/acwell/dermild-airy-sun-control-stick/ingredient_list#info-section",
    "https://www.skincarisma.com/products/acwell/dermild-fresh-sun-control-essence/ingredient_list#info-section",
    "https://www.skincarisma.com/products/acwell/honey-anti-wrinkle-mask/ingredient_list#info-section",
    "https://www.skincarisma.com/products/acwell/licorice-ph-balancing-cleansing-toner/ingredient_list#info-section",
    "https://www.skincarisma.com/products/acwell/licorice-ph-balancing-essence-mist/ingredient_list#info-section",
    "https://www.skincarisma.com/products/acwell/no-5-5-ph-balancing-micro-cleansing-foam/ingredient_list#info-section",
    "https://www.skincarisma.com/products/acwell/sensitive-solution-sun-control-cream/ingredient_list#info-section",
    "https://www.skincarisma.com/products/acwell/traditional-grain-syrup-mugwort-mask/ingredient_list#info-section",
    "https://www.skincarisma.com/products/acwell/water-moisture-mask/ingredient_list#info-section",
    "https://www.skincarisma.com/products/ada-tina/normalize-solar-matte-intense-fps-50/ingredient_list#info-section",
    "https://www.skincarisma.com/products/ada-tina/pure-c-20-mousse/ingredient_list#info-section",
    "https://www.skincarisma.com/products/adaline/keep-cool-and-drink-ocean-face-mask/ingredient_list#info-section",
    "https://www.skincarisma.com/products/adaline/keep-cool-and-let-shine-intensive-whitening-second-skin-mask/ingredient_list#info-section",
    "https://www.skincarisma.com/products/adaline/keep-cool-and-soothe-yourself-face-mask/ingredient_list#info-section",
    "https://www.skincarisma.com/products/adaline/keep-cool-double-sensational-lip/ingredient_list#info-section",
    "https://www.skincarisma.com/products/adam-revolution/bio-intelligent-anti-aging-moisturizer/ingredient_list#info-section",
    "https://www.skincarisma.com/products/adam-revolution/bio-intelligent-eye-contour-cream/ingredient_list#info-section",
    "https://www.skincarisma.com/products/adam-revolution/oxygen-hyaluronic-boosting-moisturizer/ingredient_list#info-section",
    "https://www.skincarisma.com/products/adania/bergamot-lime-all-natural-deodorant/ingredient_list#info-section",
    "https://www.skincarisma.com/products/adania/luxe-natural-skin-defender/ingredient_list#info-section",
    "https://www.skincarisma.com/products/adania/luxurious-organic-face-oil/ingredient_list#info-section",
    "https://www.skincarisma.com/products/adania/organic-cleansing-oil/ingredient_list#info-section",
    "https://www.skincarisma.com/products/adania/peppermint-crush-treatment-shampoo/ingredient_list#info-section",
    "https://www.skincarisma.com/products/adcos-professional/clarispot-clareador-pontual/ingredient_list#info-section",
    "https://www.skincarisma.com/products/adcos-professional/clean-solution-mascara-ultra-suavizante/ingredient_list#info-section",
    "https://www.skincarisma.com/products/adcos-professional/derma-complex-concentrado-vitamina-c-20/ingredient_list#info-section",
    "https://www.skincarisma.com/products/adcos-professional/derma-complex-vitamina-c-area-dos-olhos/ingredient_list#info-section",
    "https://www.skincarisma.com/products/adcos-professional/hyalucream-gf-creme-de-massagem-facial/ingredient_list#info-section",
    "https://www.skincarisma.com/products/adcos-professional/lumix-peel-peeling-illuminador/ingredient_list#info-section",
    "https://www.skincarisma.com/products/adcos-professional/mascara-de-massagem-de-vitamina-c/ingredient_list#info-section",
    "https://www.skincarisma.com/products/adcos-professional/mascara-tensora-dourada/ingredient_list#info-section",
    "https://www.skincarisma.com/products/adcos-professional/melan-off-clareador/ingredient_list#info-section",
    "https://www.skincarisma.com/products/adcos-professional/sensi-solution-tonico-suavizante/ingredient_list#info-section",
    "https://www.skincarisma.com/products/adcos/locao-secativa-fps-30-incolor/ingredient_list#info-section",
    "https://www.skincarisma.com/products/add-actives/c20-tetraforce-activator/ingredient_list#info-section",
    "https://www.skincarisma.com/products/addiction/sheer-loose-powder/ingredient_list#info-section",
    "https://www.skincarisma.com/products/addiction/sheer-pressed-powder/ingredient_list#info-section",
    "https://www.skincarisma.com/products/adidas/climacool-deodorant-body-spray-for-men/ingredient_list#info-section",
    "https://www.skincarisma.com/products/adler-pharma/seborive/ingredient_list#info-section",
    "https://www.skincarisma.com/products/adorlee/blueberry-anti-oxidant-super-defense-mask/ingredient_list#info-section",
    "https://www.skincarisma.com/products/adorlee/green-tea-pore-minimizing-detox-mask/ingredient_list#info-section",
    "https://www.skincarisma.com/products/adorlee/tea-tree-oil-anti-blemish-purifying-mask/ingredient_list#info-section",
    "https://www.skincarisma.com/products/advanced-clinicals/anti-aging-vitamin-c/ingredient_list#info-section",
    "https://www.skincarisma.com/products/advanced-clinicals/collagen/ingredient_list#info-section",
    "https://www.skincarisma.com/products/advanced-clinicals/coq10-wrinkle-defense-cream/ingredient_list#info-section",
    "https://www.skincarisma.com/products/advanced-clinicals/hyaluronic-serum-881a8849-21f6-4de2-8e1f-923a7ffed8e8/ingredient_list#info-section",
    "https://www.skincarisma.com/products/advanced-clinicals/retinol-serum-100c044f-acd3-4175-9677-9f7223320e2a/ingredient_list#info-section",
    "https://www.skincarisma.com/products/advanced-clinicals/tea-tree-oil-for-redness-and-bumps/ingredient_list#info-section",
    "https://www.skincarisma.com/products/adversa/base-liquida-matte/ingredient_list#info-section",
    "https://www.skincarisma.com/products/aenon/rituall-cleanse-gentle-facial-cleanser-d5844540-fe3b-47ff-9220-63c9acb748d4/ingredient_list#info-section",
    "https://www.skincarisma.com/products/aenon/rituall-hydrate-antioxidant-serum/ingredient_list#info-section",
    "https://www.skincarisma.com/products/aenon/rituall-tone-refining-face-toner/ingredient_list#info-section",
    "https://www.skincarisma.com/products/aeria-skin/even-tone-brightening-mask/ingredient_list#info-section",
    "https://www.skincarisma.com/products/aeria-skin/intensive-hydrating-mask/ingredient_list#info-section",
    "https://www.skincarisma.com/products/aerin/rose-night-table-cream-overnight-mask/ingredient_list#info-section",
    "https://www.skincarisma.com/products/aesop/b-tea-balancing-toner/ingredient_list#info-section",
    "https://www.skincarisma.com/products/aesop/b-triple-c-facial-balancing-gel/ingredient_list#info-section",
    "https://www.skincarisma.com/products/aesop/bitter-orange-astringent-toner/ingredient_list#info-section",
    "https://www.skincarisma.com/products/aesop/camellia-nut-facial-hydrating-cream/ingredient_list#info-section",
    "https://www.skincarisma.com/products/aesop/chamomile-concentrate-anti-blemish-masque/ingredient_list#info-section",
    "https://www.skincarisma.com/products/aesop/classic-conditioner/ingredient_list#info-section",
    "https://www.skincarisma.com/products/aesop/colour-protection-conditioner/ingredient_list#info-section",
    "https://www.skincarisma.com/products/aesop/control/ingredient_list#info-section",
    "https://www.skincarisma.com/products/aesop/control-serum/ingredient_list#info-section",
    "https://www.skincarisma.com/products/aesop/damascan-rose-facial-treatment/ingredient_list#info-section",
    "https://www.skincarisma.com/products/aesop/fabulous-face-cleanser/ingredient_list#info-section",
    "https://www.skincarisma.com/products/aesop/fabulous-face-oil/ingredient_list#info-section",
    "https://www.skincarisma.com/products/aesop/geranium-leaf-body-cleanser/ingredient_list#info-section",
    "https://www.skincarisma.com/products/aesop/geranium-leaf-body-scrub/ingredient_list#info-section",
    "https://www.skincarisma.com/products/aesop/immediate-moisture-facial-hydrosol/ingredient_list#info-section",
    "https://www.skincarisma.com/products/aesop/in-two-minds-facial-cleanser/ingredient_list#info-section",
    "https://www.skincarisma.com/products/aesop/in-two-minds-facial-hydrator/ingredient_list#info-section",
    "https://www.skincarisma.com/products/aesop/lucent-facial-concentrate/ingredient_list#info-section",
    "https://www.skincarisma.com/products/aesop/mandarin-facial-hydrating-cream/ingredient_list#info-section",
    "https://www.skincarisma.com/products/aesop/moroccan-neroli-post-shave-lotion/ingredient_list#info-section",
    "https://www.skincarisma.com/products/aesop/moroccan-neroli-shaving-serum/ingredient_list#info-section",
    "https://www.skincarisma.com/products/aesop/oil-free-facial-hydrating-serum/ingredient_list#info-section",
    "https://www.skincarisma.com/products/aesop/parsley-seed-anti-oxidant-eye-cream/ingredient_list#info-section",
    "https://www.skincarisma.com/products/aesop/parsley-seed-anti-oxidant-eye-serum/ingredient_list#info-section",
    "https://www.skincarisma.com/products/aesop/parsley-seed-anti-oxidant-facial-toner/ingredient_list#info-section",
    "https://www.skincarisma.com/products/aesop/parsley-seed-anti-oxidant-facial-treatment/ingredient_list#info-section",
    "https://www.skincarisma.com/products/aesop/parsley-seed-anti-oxidant-hydrator/ingredient_list#info-section",
    "https://www.skincarisma.com/products/aesop/parsley-seed-anti-oxidant-serum/ingredient_list#info-section",
    "https://www.skincarisma.com/products/aesop/parsley-seed-cleansing-masque/ingredient_list#info-section",
    "https://www.skincarisma.com/products/aesop/parsley-seed-facial-cleanser/ingredient_list#info-section",
    "https://www.skincarisma.com/products/aesop/parsley-seed-facial-cleansing-masque/ingredient_list#info-section",
    "https://www.skincarisma.com/products/aesop/perfect-facial-hydrating-cream/ingredient_list#info-section",
    "https://www.skincarisma.com/products/aesop/primrose-facial-cleansing-masque/ingredient_list#info-section",
    "https://www.skincarisma.com/products/aesop/purifying-facial-cream-cleanser/ingredient_list#info-section",
    "https://www.skincarisma.com/products/aesop/purifying-facial-exfoliant-paste/ingredient_list#info-section",
    "https://www.skincarisma.com/products/aesop/rind-concentrate-body-balm/ingredient_list#info-section",
    "https://www.skincarisma.com/products/aesop/rosehip-lip-seed-oil/ingredient_list#info-section",
    "https://www.skincarisma.com/products/aesop/rosehip-seed-lip-cream/ingredient_list#info-section",
    "https://www.skincarisma.com/products/aesop/sage-and-zinc-facial-hydrating-cream-spf-15/ingredient_list#info-section",
    "https://www.skincarisma.com/products/aesop/tea-tree-leaf-facial-exfoliant/ingredient_list#info-section",
    "https://www.skincarisma.com/products/aesop/volumising-conditioner/ingredient_list#info-section",
    "https://www.skincarisma.com/products/aesthetics-rx/c-serum-23-radiant-firming/ingredient_list#info-section",
    "https://www.skincarisma.com/products/aestura/atobarrier-cream/ingredient_list#info-section",
    "https://www.skincarisma.com/products/aestura/theracne-365-spot-treatment/ingredient_list#info-section",
    "https://www.skincarisma.com/products/aether-beauty/rose-quartz-crystal-gemstone-palette/ingredient_list#info-section",
    "https://www.skincarisma.com/products/affect-cosmetics/pure-passion-eyeshadow-palette/ingredient_list#info-section",
    "https://www.skincarisma.com/products/aflorence-skincare/hydrating-gel-cleanser/ingredient_list#info-section",
    "https://www.skincarisma.com/products/aflorence-skincare/skin-barrier-restoring-oil-serum-with-cholesterol-ceramides-oat/ingredient_list#info-section",
    "https://www.skincarisma.com/products/africa-s-best-textures/anti-breakage-fab-5-natural-growth-oil/ingredient_list#info-section",
    "https://www.skincarisma.com/products/africa-s-best-textures/anti-breakage-formula-coconut-growth-oil/ingredient_list#info-section",
    "https://www.skincarisma.com/products/africa-s-best-textures/coconut-sweet-almond-oil-natural-growth-oil/ingredient_list#info-section",
    "https://www.skincarisma.com/products/africa-s-best-textures/jamaican-black-castor-argan-oil-natural-growth-oil/ingredient_list#info-section",
    "https://www.skincarisma.com/products/africa-s-best-textures/nutrient-rich-porosity-repair-natural-growth-oil/ingredient_list#info-section",
    "https://www.skincarisma.com/products/africa-s-best-textures/shea-butter-herbal-care-sulfate-free-moisturizing-conditioning-shampoo/ingredient_list#info-section",
    "https://www.skincarisma.com/products/africa-s-best-textures/shea-butter-moisture-renew-deep-conditioner-treatment/ingredient_list#info-section",
    "https://www.skincarisma.com/products/african-botanics/baobab-clay-oxygenating-cleanser/ingredient_list#info-section",
    "https://www.skincarisma.com/products/african-botanics/buchu-botanical-enzyme-polish/ingredient_list#info-section",
    "https://www.skincarisma.com/products/african-botanics/cloudburst-micro-emulsion-balancing-moisturizer/ingredient_list#info-section",
    "https://www.skincarisma.com/products/african-botanics/fleurs-d-afrique-intensive-recovery-cream/ingredient_list#info-section",
    "https://www.skincarisma.com/products/african-botanics/fleurs-d-afrique-intensive-recovery-oil/ingredient_list#info-section",
    "https://www.skincarisma.com/products/african-botanics/infinite-resurfacing-mask/ingredient_list#info-section",
    "https://www.skincarisma.com/products/african-botanics/intense-skin-repair-balm/ingredient_list#info-section",
    "https://www.skincarisma.com/products/african-botanics/neroli-infused-marula-oil/ingredient_list#info-section",
    "https://www.skincarisma.com/products/african-botanics/nutritive-molecule-serum/ingredient_list#info-section",
    "https://www.skincarisma.com/products/african-botanics/pure-marula-cleansing-oil/ingredient_list#info-section",
    "https://www.skincarisma.com/products/african-botanics/resurrection-eye-creme/ingredient_list#info-section",
    "https://www.skincarisma.com/products/african-botanics/rose-treatment-essence/ingredient_list#info-section",
    "https://www.skincarisma.com/products/african-extracts-rooibos/dual-action-moisturiser-purifying/ingredient_list#info-section",
    "https://www.skincarisma.com/products/african-pride/argan-miracle-moisture-shine-deep-conditioning-masque/ingredient_list#info-section",
    "https://www.skincarisma.com/products/african-pride/argan-miracle-moisture-shine-leave-in-conditioner/ingredient_list#info-section",
    "https://www.skincarisma.com/products/african-pride/argan-miracle-moisture-shine-oil-treatment/ingredient_list#info-section",
    "https://www.skincarisma.com/products/africare/100-mineral-oil/ingredient_list#info-section",
    "https://www.skincarisma.com/products/afrodita-cosmetics/100-spa-secerni-piling-zactijelo/ingredient_list#info-section",
    "https://www.skincarisma.com/products/afrodita-cosmetics/4d-collagen-cream-for-dry-skin/ingredient_list#info-section",
    "https://www.skincarisma.com/products/afrodita-cosmetics/4d-collagen-eye-cream/ingredient_list#info-section",
    "https://www.skincarisma.com/products/afrodita-cosmetics/4d-collagen-lifting-effect-cream-for-normal-to-combination-skin/ingredient_list#info-section",
    "https://www.skincarisma.com/products/afrodita-cosmetics/4d-collagen-lifting-effect-moisturizing-serum/ingredient_list#info-section",
    "https://www.skincarisma.com/products/afrodita-cosmetics/ageless-night-creme/ingredient_list#info-section",
    "https://www.skincarisma.com/products/afrodita-cosmetics/almond-sos-krema-za-ruke-i-nokte/ingredient_list#info-section",
    "https://www.skincarisma.com/products/afrodita-cosmetics/aloe-vera-tonic-hydra/ingredient_list#info-section",
    "https://www.skincarisma.com/products/afrodita-cosmetics/aloe-vera-tonik-hydra/ingredient_list#info-section",
    "https://www.skincarisma.com/products/afrodita-cosmetics/anti-pollution-serum/ingredient_list#info-section",
    "https://www.skincarisma.com/products/afrodita-cosmetics/badem-prirodno-ulje/ingredient_list#info-section",
    "https://www.skincarisma.com/products/afrodita-cosmetics/blueberries-gel-za-tusiranje/ingredient_list#info-section",
    "https://www.skincarisma.com/products/afrodita-cosmetics/camomile-nourishing-cream/ingredient_list#info-section",
    "https://www.skincarisma.com/products/afrodita-cosmetics/cinnamon-honey-mlijeko-za-tijelo/ingredient_list#info-section",
    "https://www.skincarisma.com/products/afrodita-cosmetics/clean-phase-cleansing-foam/ingredient_list#info-section",
    "https://www.skincarisma.com/products/afrodita-cosmetics/clean-phase-cleansing-gel/ingredient_list#info-section",
    "https://www.skincarisma.com/products/afrodita-cosmetics/clean-phase-kremasti-piling/ingredient_list#info-section",
    "https://www.skincarisma.com/products/afrodita-cosmetics/clean-phase-micelarna-otopina/ingredient_list#info-section",
    "https://www.skincarisma.com/products/afrodita-cosmetics/clean-phase-mlijeko-za-ciscenje-soft/ingredient_list#info-section",
    "https://www.skincarisma.com/products/afrodita-cosmetics/clean-phase-re-balance-cistilna-pena/ingredient_list#info-section",
    "https://www.skincarisma.com/products/afrodita-cosmetics/clean-phase-sensitive-tonik/ingredient_list#info-section",
    "https://www.skincarisma.com/products/afrodita-cosmetics/clean-phase-tonik-soft/ingredient_list#info-section",
    "https://www.skincarisma.com/products/afrodita-cosmetics/clean-up-hyaluron-mlijeko-za-ciscenje/ingredient_list#info-section",
    "https://www.skincarisma.com/products/afrodita-cosmetics/coconut-milk-njegujuce-mlijeko-za-tijelo/ingredient_list#info-section",
    "https://www.skincarisma.com/products/afrodita-cosmetics/depilation-gel-nakon-depilacije-3u1/ingredient_list#info-section",
    "https://www.skincarisma.com/products/afrodita-cosmetics/family-cream-aloe-vera/ingredient_list#info-section",
    "https://www.skincarisma.com/products/afrodita-cosmetics/firming-moisturising-cream/ingredient_list#info-section",
    "https://www.skincarisma.com/products/afrodita-cosmetics/firming-nourishing-cream/ingredient_list#info-section",
    "https://www.skincarisma.com/products/afrodita-cosmetics/hyaluron-hydro-mask/ingredient_list#info-section",
    "https://www.skincarisma.com/products/afrodita-cosmetics/hyaluron-lift-lift-nourishing-creme/ingredient_list#info-section",
    "https://www.skincarisma.com/products/afrodita-cosmetics/hyaluron-lift-lifting-concentrate/ingredient_list#info-section",
    "https://www.skincarisma.com/products/afrodita-cosmetics/hydra-patch-h2o/ingredient_list#info-section",
    "https://www.skincarisma.com/products/afrodita-cosmetics/hydra-patch-h2o-ampoules/ingredient_list#info-section",
    "https://www.skincarisma.com/products/afrodita-cosmetics/hydra-patch-h2o-hydraboost-serum/ingredient_list#info-section",
    "https://www.skincarisma.com/products/afrodita-cosmetics/hydra-patch-h2o-krema-za-podrucje-oko-ociju/ingredient_list#info-section",
    "https://www.skincarisma.com/products/afrodita-cosmetics/hydra-solution-tonic-aloe-vera/ingredient_list#info-section",
    "https://www.skincarisma.com/products/afrodita-cosmetics/hydra-thermal-24h-ultra-hidratantna-krema-za-normalnu-do-mjesovite-kozu/ingredient_list#info-section",
    "https://www.skincarisma.com/products/afrodita-cosmetics/hydra-thermal-hydra-active-koncentrat/ingredient_list#info-section",
    "https://www.skincarisma.com/products/afrodita-cosmetics/hydra-thermal-krema-protiv-prvih-bora-za-podrucje-oko-ociju/ingredient_list#info-section",
    "https://www.skincarisma.com/products/afrodita-cosmetics/kamilica-sensitive-krema-oko-ociju/ingredient_list#info-section",
    "https://www.skincarisma.com/products/afrodita-cosmetics/men-24h-age-protect-krema/ingredient_list#info-section",
    "https://www.skincarisma.com/products/afrodita-cosmetics/men-3-u-1-after-shave-balzam/ingredient_list#info-section",
    "https://www.skincarisma.com/products/afrodita-cosmetics/men-3d-sensitive-shave-gel/ingredient_list#info-section",
    "https://www.skincarisma.com/products/afrodita-cosmetics/men-after-shave-lotion/ingredient_list#info-section",
    "https://www.skincarisma.com/products/afrodita-cosmetics/men-hydra-extreme-krema/ingredient_list#info-section",
    "https://www.skincarisma.com/products/afrodita-cosmetics/men-sport-gel-za-samponiranje-i-tusiranje/ingredient_list#info-section",
    "https://www.skincarisma.com/products/afrodita-cosmetics/miracle-eye-serum/ingredient_list#info-section",
    "https://www.skincarisma.com/products/afrodita-cosmetics/natural-lift-krema-protiv-bora-oko-ociju/ingredient_list#info-section",
    "https://www.skincarisma.com/products/afrodita-cosmetics/pearl-prestige-elixir-of-beauty/ingredient_list#info-section",
    "https://www.skincarisma.com/products/afrodita-cosmetics/pearl-prestige-exclusive-moisturizing-creme/ingredient_list#info-section",
    "https://www.skincarisma.com/products/afrodita-cosmetics/pure-gold-24-ka-raskosna-krema-za-oci/ingredient_list#info-section",
    "https://www.skincarisma.com/products/afrodita-cosmetics/pure-oxygen-vitalizirajuca-nocna-krema/ingredient_list#info-section",
    "https://www.skincarisma.com/products/afrodita-cosmetics/re-balance-anti-pollution-tonik/ingredient_list#info-section",
    "https://www.skincarisma.com/products/afrodita-cosmetics/red-grapes-revitalising-oil-shower-gel/ingredient_list#info-section",
    "https://www.skincarisma.com/products/afrodita-cosmetics/secret-advanced-renew-serum/ingredient_list#info-section",
    "https://www.skincarisma.com/products/afrodita-cosmetics/secret-glow-mask/ingredient_list#info-section",
    "https://www.skincarisma.com/products/afrodita-cosmetics/sun-care-facial-sunscreen-age-difference-spf-25/ingredient_list#info-section",
    "https://www.skincarisma.com/products/afrodita-cosmetics/sun-care-facial-sunscreen-sensitive-spf-30/ingredient_list#info-section",
    "https://www.skincarisma.com/products/afrodita-cosmetics/vita-derma-acne-ampule/ingredient_list#info-section",
    "https://www.skincarisma.com/products/afrodita-cosmetics/young-pure-gel-za-ciscenje-piling-maska-3-u-1/ingredient_list#info-section",
    "https://www.skincarisma.com/products/afrodita-cosmetics/young-pure-njegujuca-matirajuca-krema/ingredient_list#info-section",
    "https://www.skincarisma.com/products/afrodita-cosmetics/young-pure-osvjezavajuca-maska/ingredient_list#info-section",
    "https://www.skincarisma.com/products/afrodita-cosmetics/young-pure-osvjezavajuci-tonik/ingredient_list#info-section",
    "https://www.skincarisma.com/products/afroveda-ayurvedic-hair-care/foundation-pumpkin-pomegranate-sulfate-free-shampoo/ingredient_list#info-section",
    "https://www.skincarisma.com/products/ag-hair/balance-shampoo/ingredient_list#info-section",
    "https://www.skincarisma.com/products/ag-hair/fast-food-leave-on-conditioner/ingredient_list#info-section",
    "https://www.skincarisma.com/products/ag-hair/the-oil-extra-virgin-argan-miracle-smoothing-oil/ingredient_list#info-section",
    "https://www.skincarisma.com/products/agadir/argan-oil-daily-moisturizing-conditioner/ingredient_list#info-section",
    "https://www.skincarisma.com/products/agadir/argan-oil-daily-moisturizing-shampoo-sulfate-free/ingredient_list#info-section",
    "https://www.skincarisma.com/products/agatha/essentiel-sun-protection-cream-spf50-pa/ingredient_list#info-section",
    "https://www.skincarisma.com/products/age-20-s/essence-cover-pact-white-latte/ingredient_list#info-section",
    "https://www.skincarisma.com/products/age-20-s/original-essence-cover-pact/ingredient_list#info-section",
    "https://www.skincarisma.com/products/age-20-s/signature-essence-cover-pact-intense-cover/ingredient_list#info-section",
    "https://www.skincarisma.com/products/age-20-s/signature-essence-cover-pact-long-stay/ingredient_list#info-section",
    "https://www.skincarisma.com/products/age-20-s/signature-essence-cover-pact-moisture/ingredient_list#info-section",
    "https://www.skincarisma.com/products/age-harmony/30-night-cream/ingredient_list#info-section",
    "https://www.skincarisma.com/products/agent-nateur/holi-c/ingredient_list#info-section",
    "https://www.skincarisma.com/products/agent-nateur/holi-water/ingredient_list#info-section",
    "https://www.skincarisma.com/products/aha/cleansing-research-wash-cleansing/ingredient_list#info-section",
    "https://www.skincarisma.com/products/aha/cleansing-water-oil-free-b/ingredient_list#info-section",
    "https://www.skincarisma.com/products/ahava/24k-gold-mineral-mud-mask/ingredient_list#info-section",
    "https://www.skincarisma.com/products/ahava/active-deadsea-minerals-deadsea-plants-caressing-body-sorbet/ingredient_list#info-section",
    "https://www.skincarisma.com/products/ahava/after-sun-body-lotion/ingredient_list#info-section",
    "https://www.skincarisma.com/products/ahava/age-control-eye-cream/ingredient_list#info-section",
    "https://www.skincarisma.com/products/ahava/age-defying-all-night-nourishment/ingredient_list#info-section",
    "https://www.skincarisma.com/products/ahava/beauty-before-age-uplift-day-cream/ingredient_list#info-section",
    "https://www.skincarisma.com/products/ahava/beauty-before-age-uplift-night-cream/ingredient_list#info-section",
    "https://www.skincarisma.com/products/ahava/clearing-facial-treatment-mask/ingredient_list#info-section",
    "https://www.skincarisma.com/products/ahava/dead-sea-mud-gentle-body-exfoliator/ingredient_list#info-section",
    "https://www.skincarisma.com/products/ahava/dead-sea-osmoter-concentrate/ingredient_list#info-section",
    "https://www.skincarisma.com/products/ahava/dead-sea-osmoter-eye-concentrate/ingredient_list#info-section",
    "https://www.skincarisma.com/products/ahava/dead-sea-water-mineral-foot-cream/ingredient_list#info-section",
    "https://www.skincarisma.com/products/ahava/deadsea-plants-dry-oil-body-mist/ingredient_list#info-section",
    "https://www.skincarisma.com/products/ahava/dermud-intensive-foot-cream/ingredient_list#info-section",
    "https://www.skincarisma.com/products/ahava/dermud-intensive-hand-cream/ingredient_list#info-section",
    "https://www.skincarisma.com/products/ahava/dermud-nourishing-body-cream/ingredient_list#info-section",
    "https://www.skincarisma.com/products/ahava/essential-day-moisturizer-combination/ingredient_list#info-section",
    "https://www.skincarisma.com/products/ahava/essential-day-moisturizer-normal-to-dry/ingredient_list#info-section",
    "https://www.skincarisma.com/products/ahava/extreme-day-cream/ingredient_list#info-section",
    "https://www.skincarisma.com/products/ahava/extreme-firming-eye-cream/ingredient_list#info-section",
    "https://www.skincarisma.com/products/ahava/extreme-night-treatment/ingredient_list#info-section",
    "https://www.skincarisma.com/products/ahava/extreme-radiance-lifting-mask/ingredient_list#info-section",
    "https://www.skincarisma.com/products/ahava/eye-makeup-remover/ingredient_list#info-section",
    "https://www.skincarisma.com/products/ahava/facial-renewal-peel/ingredient_list#info-section",
    "https://www.skincarisma.com/products/ahava/firming-body-cream/ingredient_list#info-section",
    "https://www.skincarisma.com/products/ahava/foam-free-silk-shave/ingredient_list#info-section",
    "https://www.skincarisma.com/products/ahava/hand-cream-for-men/ingredient_list#info-section",
    "https://www.skincarisma.com/products/ahava/hydration-cream-mask/ingredient_list#info-section",
    "https://www.skincarisma.com/products/ahava/mens-time-to-energize-age-control-all-in-one-eye-care/ingredient_list#info-section",
    "https://www.skincarisma.com/products/ahava/mineral-body-shaper-cellulite-control/ingredient_list#info-section",
    "https://www.skincarisma.com/products/ahava/night-replenisher-normal-to-dry/ingredient_list#info-section",
    "https://www.skincarisma.com/products/ahava/purifying-mud-mask/ingredient_list#info-section",
    "https://www.skincarisma.com/products/ahava/purifying-mud-mask-for-oily-skin/ingredient_list#info-section",
    "https://www.skincarisma.com/products/ahava/rich-cleansing-cream/ingredient_list#info-section",
    "https://www.skincarisma.com/products/ahava/skin-replenisher-night-for-normal-to-dry-skin/ingredient_list#info-section",
    "https://www.skincarisma.com/products/ahava/sun-protection-anti-aging-facial-moisturizer-spf-50/ingredient_list#info-section",
    "https://www.skincarisma.com/products/ahava/sun-protection-anti-aging-moisturizer-spf-15/ingredient_list#info-section",
    "https://www.skincarisma.com/products/ahava/sun-protection-anti-aging-moisturizer-spf-30/ingredient_list#info-section",
    "https://www.skincarisma.com/products/ahava/sun-protection-anti-aging-moisturizer-spf-50/ingredient_list#info-section",
    "https://www.skincarisma.com/products/ahava/time-to-clear-all-in-one-toning-cleanser/ingredient_list#info-section",
    "https://www.skincarisma.com/products/ahava/time-to-clear-purifying-mud-mask/ingredient_list#info-section",
    "https://www.skincarisma.com/products/ahava/time-to-clear-refreshing-cleansing-gel/ingredient_list#info-section",
    "https://www.skincarisma.com/products/ahava/time-to-hydrate-active-moisture-gel-cream/ingredient_list#info-section",
    "https://www.skincarisma.com/products/ahava/time-to-hydrate-essential-day-moisturizer-combination-skin/ingredient_list#info-section",
    "https://www.skincarisma.com/products/ahava/time-to-hydrate-essential-day-moisturizer-normal-to-dry-skin/ingredient_list#info-section",
    "https://www.skincarisma.com/products/ahava/time-to-hydrate-essential-reviving-serum/ingredient_list#info-section",
    "https://www.skincarisma.com/products/ahava/time-to-hydrate-gentle-eye-cream/ingredient_list#info-section",
    "https://www.skincarisma.com/products/ahava/time-to-hydrate-night-replenisher-normal-to-dry-skin/ingredient_list#info-section",
    "https://www.skincarisma.com/products/ahava/time-to-revitalize-extreme-radiance-lifting-mask/ingredient_list#info-section",
    "https://www.skincarisma.com/products/ahava/time-to-smooth-age-control-all-day-moisturizer-spf-15/ingredient_list#info-section",
    "https://www.skincarisma.com/products/ahava/time-to-smooth-age-control-even-tone-moisturizer/ingredient_list#info-section",
    "https://www.skincarisma.com/products/ahava/time-to-smooth-age-control-eye-cream/ingredient_list#info-section",
    "https://www.skincarisma.com/products/ahava/time-to-smooth-age-control-intensive-serum/ingredient_list#info-section",
    "https://www.skincarisma.com/products/ahava/time-to-smooth-age-control-night-nourishment/ingredient_list#info-section",
    "https://www.skincarisma.com/products/ahc/capture-moist-solution-ampoule/ingredient_list#info-section",
    "https://www.skincarisma.com/products/ahc/capture-solucao-umida-max-ampoule/ingredient_list#info-section",
    "https://www.skincarisma.com/products/ahc/hyaluronic-toner/ingredient_list#info-section",
    "https://www.skincarisma.com/products/ahc/natural-perfection-sun-stick-spf-50-pa/ingredient_list#info-section",
    "https://www.skincarisma.com/products/ahc/peony-bright-clearing-toner/ingredient_list#info-section",
    "https://www.skincarisma.com/products/ahc/perfect-dual-cover-cushion-glam-pink-no-21/ingredient_list#info-section",
    "https://www.skincarisma.com/products/ahc/premium-hydra-b5-sleeping-pack/ingredient_list#info-section",
    "https://www.skincarisma.com/products/ahc/premium-hydra-b5-soother/ingredient_list#info-section",
    "https://www.skincarisma.com/products/ahc/premium-hydra-b5-toner/ingredient_list#info-section",
    "https://www.skincarisma.com/products/ahc/skinfit-correcting-dual-cushion-no-21/ingredient_list#info-section",
    "https://www.skincarisma.com/products/aiken/100-pure-tea-tree-oil/ingredient_list#info-section",
    "https://www.skincarisma.com/products/aiken/aiken-tea-tree-oil-cleanser/ingredient_list#info-section",
    "https://www.skincarisma.com/products/aiken/daily-sunscreen-face-body-lotion/ingredient_list#info-section",
    "https://www.skincarisma.com/products/aiken/gentle-care-tea-tree-oil-aloe-vera/ingredient_list#info-section",
    "https://www.skincarisma.com/products/aiken/pimple-cream/ingredient_list#info-section",
    "https://www.skincarisma.com/products/aiken/tea-tree-oil-face-body-day-lotion-spf25/ingredient_list#info-section",
    "https://www.skincarisma.com/products/aiken/tea-tree-oil-moisturizer-4de1a86f-e643-4ee5-aa2f-28de460bc773/ingredient_list#info-section",
    "https://www.skincarisma.com/products/aiken/tea-tree-oil-spot-away-pore-refining-toner/ingredient_list#info-section",
    "https://www.skincarisma.com/products/aiken/tea-tree-oil-toner/ingredient_list#info-section",
    "https://www.skincarisma.com/products/aippo/expert-hydrating-mask-sheet/ingredient_list#info-section",
    "https://www.skincarisma.com/products/aippo/expert-soothing-ampoule/ingredient_list#info-section",
    "https://www.skincarisma.com/products/airinbeautycare/anti-acne-serum-88eb9210-ad29-4491-a7d6-daa4732b0373/ingredient_list#info-section",
    "https://www.skincarisma.com/products/aishaderm/mousturizing-facial-wash/ingredient_list#info-section",
    "https://www.skincarisma.com/products/aisti/hajustamaton-kosteusemulsio/ingredient_list#info-section",
    "https://www.skincarisma.com/products/akar-skin/pure-lip-restoration/ingredient_list#info-section",
    "https://www.skincarisma.com/products/akar-skin/soothe-face-oil/ingredient_list#info-section",
    "https://www.skincarisma.com/products/akaran/essential-water-gel/ingredient_list#info-section",
    "https://www.skincarisma.com/products/akedemiklinikken/pure-antioxidant-cream/ingredient_list#info-section",
    "https://www.skincarisma.com/products/aknicare/cleanser-3bb71d4d-04fc-4c22-850e-2d53877b5a2c/ingredient_list#info-section",
    "https://www.skincarisma.com/products/aknicare/cream-630f4183-d34d-4fa3-be96-87628415c88f/ingredient_list#info-section",
    "https://www.skincarisma.com/products/alaffia/africa-s-secret-multipurpose-skin-cream/ingredient_list#info-section",
    "https://www.skincarisma.com/products/alaffia/baobab-rooibos-the-dry-skin-cooling-gel-hydration-mask/ingredient_list#info-section",
    "https://www.skincarisma.com/products/alaffia/coconut-face-cleanser/ingredient_list#info-section",
    "https://www.skincarisma.com/products/alaffia/neem-tumeric-cleanser-with-yarrow-moringa/ingredient_list#info-section",
    "https://www.skincarisma.com/products/alastin-skincare/regenerating-skin-nectar/ingredient_list#info-section",
    "https://www.skincarisma.com/products/alba-1913/galenic-leave-on-mask/ingredient_list#info-section",
    "https://www.skincarisma.com/products/alba-1913/metropolitan-skin-guard-concentrate/ingredient_list#info-section",
    "https://www.skincarisma.com/products/alba-1913/metropolitan-skin-guard-mist/ingredient_list#info-section",
    "https://www.skincarisma.com/products/alba-botanica/acne-dote-daily-cleansing-towelettes-oil-free/ingredient_list#info-section",
    "https://www.skincarisma.com/products/alba-botanica/acne-dote-deep-pore-wash-oil-free/ingredient_list#info-section",
    "https://www.skincarisma.com/products/alba-botanica/acne-dote-face-body-scrub/ingredient_list#info-section",
    "https://www.skincarisma.com/products/alba-botanica/acne-dote-invisible-treatment-gel-oil-free/ingredient_list#info-section",
    "https://www.skincarisma.com/products/alba-botanica/acne-dote-oil-control-lotion-oil-free/ingredient_list#info-section",
    "https://www.skincarisma.com/products/alba-botanica/acnedote-deep-pore-wash/ingredient_list#info-section",
    "https://www.skincarisma.com/products/alba-botanica/acnedote-face-body-scrub/ingredient_list#info-section",
    "https://www.skincarisma.com/products/alba-botanica/acnedote-invisible-treatment-gel/ingredient_list#info-section",
    "https://www.skincarisma.com/products/alba-botanica/acnedote-maximum-strength-clean-n-treat-daily-cleansing-towelettes/ingredient_list#info-section",
    "https://www.skincarisma.com/products/alba-botanica/acnedote-oil-control-lotion/ingredient_list#info-section",
    "https://www.skincarisma.com/products/alba-botanica/deep-cleansing-coconut-milk/ingredient_list#info-section",
    "https://www.skincarisma.com/products/alba-botanica/even-advanced-night-cream-with-dmae-thioctic-acid-sea-plus-renewal/ingredient_list#info-section",
    "https://www.skincarisma.com/products/alba-botanica/even-advanced-sea-algae-enzyme-facial-scrub/ingredient_list#info-section",
    "https://www.skincarisma.com/products/alba-botanica/even-advanced-sea-elements-eye-makeup-remover/ingredient_list#info-section",
    "https://www.skincarisma.com/products/alba-botanica/even-advanced-sea-kelp-facial-toner/ingredient_list#info-section",
    "https://www.skincarisma.com/products/alba-botanica/even-advanced-sea-lettuce-cleansing-milk/ingredient_list#info-section",
    "https://www.skincarisma.com/products/alba-botanica/even-advanced-sea-lipids-daily-cream/ingredient_list#info-section",
    "https://www.skincarisma.com/products/alba-botanica/even-advanced-sea-mineral-cleansing-gel/ingredient_list#info-section",
    "https://www.skincarisma.com/products/alba-botanica/even-advanced-sea-moss-moisturizer-spf-15/ingredient_list#info-section",
    "https://www.skincarisma.com/products/alba-botanica/even-advanced-sea-plus-renewal-night-cream/ingredient_list#info-section",
    "https://www.skincarisma.com/products/alba-botanica/facial-toner-liquid-complexion-balancing-hibiscus/ingredient_list#info-section",
    "https://www.skincarisma.com/products/alba-botanica/fast-fix-for-a-pimple/ingredient_list#info-section",
]



object = {}

def start_program(links_array, empty_object)
    counter = 1
    links_array.each do |link|
        get_basic_info(link, empty_object)
        
        puts "====================================="
        puts "#{counter} scraped."
        puts "====================================="
        
        add_to_db(@scraped_product)
        
        puts "====================================="
        puts "#{counter} added to database."
        puts "====================================="
        
        counter += 1
        empty_object = {}
    end
end

start_program(links_0, object)



























































# p1 = Product.create
# p1.brand = "Neutrogena"
# p1.name = "Oil-Free Acne Wash Pink Grapefruit Facial Cleanser"
# p1.category = "cleanser"
# p1.img_url = "https://target.scene7.com/is/image/Target/11537188?wid=520&hei=520&fmt=pjpeg"
# p1.sunscreen_type = nil
# p1.spf = nil
# p1.pa = nil
# p1.save

# up1 = UserProduct.create
# up1.user_id = 13
# up1.product_id = p1.id
# up1.current = false
# up1.rating = 4
# up1.wishlist = false
# up1.opened = nil
# up1.expires = nil
# up1.caused_acne = false
# up1.notes = "A little harsh and drying."
# up1.save

# i1 = Ingredient.find_or_create_by(name: "Salicylic Acid, 2%")
# i1.como_rating = nil
# i1.save

# pi1 = ProductIngredient.create
# pi1.product_id = p1.id
# pi1.ingredient_id = i1.id
# pi1.save

# i2 = Ingredient.find_or_create_by(name: "Water")
# i2.como_rating = nil
# i2.save

# pi2 = ProductIngredient.create
# pi2.product_id = p1.id
# pi2.ingredient_id = i2.id
# pi2.save

# i3 = Ingredient.find_or_create_by(name: "Sodium C14-16 Olefin Sulfonate")
# i3.como_rating = nil
# i3.save

# pi3 = ProductIngredient.create
# pi3.product_id = p1.id
# pi3.ingredient_id = i3.id
# pi3.save

# i4 = Ingredient.find_or_create_by(name: "Cocamidopropyl Betaine")
# i4.como_rating = nil
# i4.save

# pi4 = ProductIngredient.create
# pi4.product_id = p1.id
# pi4.ingredient_id = i4.id
# pi4.save

# i5 = Ingredient.find_or_create_by(name: "Sodium Chloride")
# i5.como_rating = nil
# i5.save

# pi5 = ProductIngredient.create
# pi5.product_id = p1.id
# pi5.ingredient_id = i5.id
# pi5.save

# i6 = Ingredient.find_or_create_by(name: "PEG-120 Methyl Glucose Dioleate")
# i6.como_rating = nil
# i6.save

# pi6 = ProductIngredient.create
# pi6.product_id = p1.id
# pi6.ingredient_id = i6.id
# pi6.save

# i7 = Ingredient.find_or_create_by(name: "Polysorbate 20")
# i7.como_rating = 0
# i7.save

# pi7 = ProductIngredient.create
# pi7.product_id = p1.id
# pi7.ingredient_id = i7.id
# pi7.save

# i8 = Ingredient.find_or_create_by(name: "Linoleamidopropyl PG-Dimonium Chloride Phosphate")
# i8.como_rating = nil
# i8.save

# pi8 = ProductIngredient.create
# pi8.product_id = p1.id
# pi8.ingredient_id = i8.id
# pi8.save

# i9 = Ingredient.find_or_create_by(name: "Propylene Glycol")
# i9.como_rating = 0
# i9.save

# pi9 = ProductIngredient.create
# pi9.product_id = p1.id
# pi9.ingredient_id = i9.id
# pi9.save

# i10 = Ingredient.find_or_create_by(name: "PEG-80 Sorbitan Laurate")
# i10.como_rating = nil
# i10.save

# pi10 = ProductIngredient.create
# pi10.product_id = p1.id
# pi10.ingredient_id = i10.id
# pi10.save

# i11 = Ingredient.find_or_create_by(name: "Fragrance")
# i11.como_rating = nil
# i11.save

# pi11 = ProductIngredient.create
# pi11.product_id = p1.id
# pi11.ingredient_id = i11.id
# pi11.save

# i12 = Ingredient.find_or_create_by(name: "Disodium EDTA")
# i12.como_rating = nil
# i12.save

# pi12 = ProductIngredient.create
# pi12.product_id = p1.id
# pi12.ingredient_id = i12.id
# pi12.save

# i13 = Ingredient.find_or_create_by(name: "Benzalkonium Chloride")
# i13.como_rating = nil
# i13.save

# pi13 = ProductIngredient.create
# pi13.product_id = p1.id
# pi13.ingredient_id = i13.id
# pi13.save

# i14 = Ingredient.find_or_create_by(name: "C12-15 Alkyl Lactate")
# i14.como_rating = nil
# i14.save

# pi14 = ProductIngredient.create
# pi14.product_id = p1.id
# pi14.ingredient_id = i14.id
# pi14.save

# i15 = Ingredient.find_or_create_by(name: "Polyquaternium-7")
# i15.como_rating = nil
# i15.save

# pi15 = ProductIngredient.create
# pi15.product_id = p1.id
# pi15.ingredient_id = i15.id
# pi15.save

# i16 = Ingredient.find_or_create_by(name: "Sodium Benzotriazolyl Butylphenol Sulfonate")
# i16.como_rating = nil
# i16.save

# pi16 = ProductIngredient.create
# pi16.product_id = p1.id
# pi16.ingredient_id = i16.id
# pi16.save

# i17 = Ingredient.find_or_create_by(name: "Cocamidopropyl PG-Dimonium Chloride Phosphate")
# i17.como_rating = nil
# i17.save

# pi17 = ProductIngredient.create
# pi17.product_id = p1.id
# pi17.ingredient_id = i17.id
# pi17.save

# i18 = Ingredient.find_or_create_by(name: "Ascorbyl Palmitate")
# i18.como_rating = 2
# i18.save

# pi18 = ProductIngredient.create
# pi18.product_id = p1.id
# pi18.ingredient_id = i18.id
# pi18.save

# i19 = Ingredient.find_or_create_by(name: "Aloe Barbadensis Leaf Extract")
# i19.como_rating = nil
# i19.save

# pi19 = ProductIngredient.create
# pi19.product_id = p1.id
# pi19.ingredient_id = i19.id
# pi19.save

# i20 = Ingredient.find_or_create_by(name: "Anthemis Nobilis Flower Extract")
# i20.como_rating = nil
# i20.save

# pi20 = ProductIngredient.create
# pi20.product_id = p1.id
# pi20.ingredient_id = i20.id
# pi20.save

# i21 = Ingredient.find_or_create_by(name: "Chamomilla Recutita Flower Extract")
# i21.como_rating = nil
# i21.save

# pi21 = ProductIngredient.create
# pi21.product_id = p1.id
# pi21.ingredient_id = i21.id
# pi21.save

# i22 = Ingredient.find_or_create_by(name: "Citrus Grandis Fruit Extract")
# i22.como_rating = nil
# i22.save

# pi22 = ProductIngredient.create
# pi22.product_id = p1.id
# pi22.ingredient_id = i22.id
# pi22.save

# i23 = Ingredient.find_or_create_by(name: "Citric Acid")
# i23.como_rating = nil
# i23.save

# pi23 = ProductIngredient.create
# pi23.product_id = p1.id
# pi23.ingredient_id = i23.id
# pi23.save

# i24 = Ingredient.find_or_create_by(name: "Sodium Hydroxide")
# i24.como_rating = nil
# i24.save

# pi24 = ProductIngredient.create
# pi24.product_id = p1.id
# pi24.ingredient_id = i24.id
# pi24.save

# i25 = Ingredient.find_or_create_by(name: "Red 40")
# i25.como_rating = nil
# i25.save

# pi25 = ProductIngredient.create
# pi25.product_id = p1.id
# pi25.ingredient_id = i25.id
# pi25.save

# i26 = Ingredient.find_or_create_by(name: "Violet 2")
# i26.como_rating = nil
# i26.save

# pi26 = ProductIngredient.create
# pi26.product_id = p1.id
# pi26.ingredient_id = i26.id
# pi26.save

# ###################

# p2 = Product.create
# p2.brand = "Tula"
# p2.name = "Purifying Face Cleanser"
# p2.category = "cleanser"
# p2.img_url = "https://images.ulta.com/is/image/Ulta/2532485?op_sharpen=1&resMode=bilin&qlt=85&wid=800&hei=800&fmt=webp"
# p2.sunscreen_type = nil
# p2.spf = nil
# p2.pa = nil
# p2.save

# up2 = UserProduct.create
# up2.user_id = 13
# up2.product_id = p2.id
# up2.current = true
# up2.rating = 5 
# up2.wishlist = false
# up2.opened = nil
# up2.expires = nil
# up2.caused_acne = false
# up2.notes = "Holy Grail Cleanser!"
# up2.save

# i1 = Ingredient.find_or_create_by(name: "Eau")
# i1.como_rating = nil
# i1.save

# pi1 = ProductIngredient.create
# pi1.product_id = p2.id
# pi1.ingredient_id = i1.id
# pi1.save

# i2 = Ingredient.find_or_create_by(name: "Cocamidopropyl Betaine")
# i2.como_rating = nil
# i2.save

# pi2 = ProductIngredient.create
# pi2.product_id = p2.id
# pi2.ingredient_id = i2.id
# pi2.save

# i3 = Ingredient.find_or_create_by(name: "PEG-80 Sorbitan Laurate")
# i3.como_rating = nil
# i3.save

# pi3 = ProductIngredient.create
# pi3.product_id = p2.id
# pi3.ingredient_id = i3.id
# pi3.save

# i4 = Ingredient.find_or_create_by(name: "Sodium Trideceth Sulfate")
# i4.como_rating = nil
# i4.save

# pi4 = ProductIngredient.create
# pi4.product_id = p2.id
# pi4.ingredient_id = i4.id
# pi4.save

# i5 = Ingredient.find_or_create_by(name: "Lauryl Glucoside")
# i5.como_rating = nil
# i5.save

# pi5 = ProductIngredient.create
# pi5.product_id = p2.id
# pi5.ingredient_id = i5.id
# pi5.save

# i6 = Ingredient.find_or_create_by(name: "Glycerin")
# i6.como_rating = 0
# i6.save

# pi6 = ProductIngredient.create
# pi6.product_id = p2.id
# pi6.ingredient_id = i6.id
# pi6.save

# i7 = Ingredient.find_or_create_by(name: "PEG 150 Distearate")
# i7.como_rating = 2
# i7.save

# pi7 = ProductIngredient.create
# pi7.product_id = p2.id
# pi7.ingredient_id = i7.id
# pi7.save

# i8 = Ingredient.find_or_create_by(name: "Lactose")
# i8.como_rating = nil
# i8.save

# pi8 = ProductIngredient.create
# pi8.product_id = p2.id
# pi8.ingredient_id = i8.id
# pi8.save

# i9 = Ingredient.find_or_create_by(name: "Milk Protein")
# i9.como_rating = nil
# i9.save

# pi9 = ProductIngredient.create
# pi9.product_id = p2.id
# pi9.ingredient_id = i9.id
# pi9.save

# i10 = Ingredient.find_or_create_by(name: "Bifida Ferment Lysate")
# i10.como_rating = nil
# i10.save

# pi10 = ProductIngredient.create
# pi10.product_id = p2.id
# pi10.ingredient_id = i10.id
# pi10.save

# i11 = Ingredient.find_or_create_by(name: "Yogurt Extract")
# i11.como_rating = nil
# i11.save

# pi11 = ProductIngredient.create
# pi11.product_id = p2.id
# pi11.ingredient_id = i11.id
# pi11.save

# i12 = Ingredient.find_or_create_by(name: "Hydrolyzed Rice Protein")
# i12.como_rating = nil
# i12.save

# pi12 = ProductIngredient.create
# pi12.product_id = p2.id
# pi12.ingredient_id = i12.id
# pi12.save

# i13 = Ingredient.find_or_create_by(name: "Cichorium Intybus Root Extract")
# i13.como_rating = nil
# i13.save

# pi13 = ProductIngredient.create
# pi13.product_id = p2.id
# pi13.ingredient_id = i13.id
# pi13.save

# i14 = Ingredient.find_or_create_by(name: "Vaccinium Angustifolium Fruit Extract")
# i14.como_rating = nil
# i14.save

# pi14 = ProductIngredient.create
# pi14.product_id = p2.id
# pi14.ingredient_id = i14.id
# pi14.save

# i15 = Ingredient.find_or_create_by(name: "Vegetable Oil")
# i15.como_rating = nil
# i15.save

# pi15 = ProductIngredient.create
# pi15.product_id = p2.id
# pi15.ingredient_id = i15.id
# pi15.save

# i16 = Ingredient.find_or_create_by(name: "Camelina Sativa Seed Oil")
# i16.como_rating = nil
# i16.save

# pi16 = ProductIngredient.create
# pi16.product_id = p2.id
# pi16.ingredient_id = i16.id
# pi16.save

# i17 = Ingredient.find_or_create_by(name: "Camellia Sinensis Leaf Extract")
# i17.como_rating = nil
# i17.save

# pi17 = ProductIngredient.create
# pi17.product_id = p2.id
# pi17.ingredient_id = i17.id
# pi17.save

# i18 = Ingredient.find_or_create_by(name: "Curcuma Longa Root Extract")
# i18.como_rating = nil
# i18.save

# pi18 = ProductIngredient.create
# pi18.product_id = p2.id
# pi18.ingredient_id = i18.id
# pi18.save

# i19 = Ingredient.find_or_create_by(name: "Tocopheryl Acetate")
# i19.como_rating = 0
# i19.save

# pi19 = ProductIngredient.create
# pi19.product_id = p2.id
# pi19.ingredient_id = i19.id
# pi19.save

# i20 = Ingredient.find_or_create_by(name: "Retinyl Palmitate")
# i20.como_rating = 2
# i20.save

# pi20 = ProductIngredient.create
# pi20.product_id = p2.id
# pi20.ingredient_id = i20.id
# pi20.save

# i21 = Ingredient.find_or_create_by(name: "Ascorbyl Palmitate")
# i21.como_rating = 2
# i21.save

# pi21 = ProductIngredient.create
# pi21.product_id = p2.id
# pi21.ingredient_id = i21.id
# pi21.save

# i22 = Ingredient.find_or_create_by(name: "Panthenol")
# i22.como_rating = 0
# i22.save

# pi22 = ProductIngredient.create
# pi22.product_id = p2.id
# pi22.ingredient_id = i22.id
# pi22.save

# i23 = Ingredient.find_or_create_by(name: "Carthamus Tinctorius Seed Oil")
# i23.como_rating = 0
# i23.save

# pi23 = ProductIngredient.create
# pi23.product_id = p2.id
# pi23.ingredient_id = i23.id
# pi23.save

# i24 = Ingredient.find_or_create_by(name: "Polyquaternium-10")
# i24.como_rating = nil
# i24.save

# pi24 = ProductIngredient.create
# pi24.product_id = p2.id
# pi24.ingredient_id = i24.id
# pi24.save

# i25 = Ingredient.find_or_create_by(name: "Butylene Glycol")
# i25.como_rating = 1
# i25.save

# pi25 = ProductIngredient.create
# pi25.product_id = p2.id
# pi25.ingredient_id = i25.id
# pi25.save

# i26 = Ingredient.find_or_create_by(name: "Sodium Chloride")
# i26.como_rating = nil
# i26.save

# pi26 = ProductIngredient.create
# pi26.product_id = p2.id
# pi26.ingredient_id = i26.id
# pi26.save

# i27 = Ingredient.find_or_create_by(name: "Pentylene Glycol")
# i27.como_rating = nil
# i27.save

# pi27 = ProductIngredient.create
# pi27.product_id = p2.id
# pi27.ingredient_id = i27.id
# pi27.save

# i28 = Ingredient.find_or_create_by(name: "Caprylyl Glycol")
# i28.como_rating = nil
# i28.save

# pi28 = ProductIngredient.create
# pi28.product_id = p2.id
# pi28.ingredient_id = i28.id
# pi28.save

# i29 = Ingredient.find_or_create_by(name: "Ethylhexylglycerin")
# i29.como_rating = nil
# i29.save

# pi29 = ProductIngredient.create
# pi29.product_id = p2.id
# pi29.ingredient_id = i29.id
# pi29.save

# i30 = Ingredient.find_or_create_by(name: "Bulnesia Sarmientoi Wood Oil")
# i30.como_rating = nil
# i30.save

# pi30 = ProductIngredient.create
# pi30.product_id = p2.id
# pi30.ingredient_id = i30.id
# pi30.save

# i31 = Ingredient.find_or_create_by(name: "Citrus Limon Fruit Oil")
# i31.como_rating = nil
# i31.save

# pi31 = ProductIngredient.create
# pi31.product_id = p2.id
# pi31.ingredient_id = i31.id
# pi31.save

# i32 = Ingredient.find_or_create_by(name: "Citrus Aurantium Dulcis (Orange) Oil")
# i32.como_rating = nil
# i32.save

# pi32 = ProductIngredient.create
# pi32.product_id = p2.id
# pi32.ingredient_id = i32.id
# pi32.save

# i33 = Ingredient.find_or_create_by(name: "Juniperus Mexicana Oil")
# i33.como_rating = nil
# i33.save

# pi33 = ProductIngredient.create
# pi33.product_id = p2.id
# pi33.ingredient_id = i33.id
# pi33.save

# i34 = Ingredient.find_or_create_by(name: "Cananga Odorata Flower Oil")
# i34.como_rating = nil
# i34.save

# pi34 = ProductIngredient.create
# pi34.product_id = p2.id
# pi34.ingredient_id = i34.id
# pi34.save

# i35 = Ingredient.find_or_create_by(name: "Fragrance")
# i35.como_rating = nil
# i35.save

# pi35 = ProductIngredient.create
# pi35.product_id = p2.id
# pi35.ingredient_id = i35.id
# pi35.save

# i36 = Ingredient.find_or_create_by(name: "Sorbic Acid")
# i36.como_rating = nil
# i36.save

# pi36 = ProductIngredient.create
# pi36.product_id = p2.id
# pi36.ingredient_id = i36.id
# pi36.save

# i37 = Ingredient.find_or_create_by(name: "Phenoxyethanol")
# i37.como_rating = nil
# i37.save

# pi37 = ProductIngredient.create
# pi37.product_id = p2.id
# pi37.ingredient_id = i37.id
# pi37.save

# i38 = Ingredient.find_or_create_by(name: "Disodium EDTA")
# i38.como_rating = nil
# i38.save

# pi38 = ProductIngredient.create
# pi38.product_id = p2.id
# pi38.ingredient_id = i38.id
# pi38.save

# i39 = Ingredient.find_or_create_by(name: "Methylchloroisothiazolinone")
# i39.como_rating = nil
# i39.save

# pi39 = ProductIngredient.create
# pi39.product_id = p2.id
# pi39.ingredient_id = i39.id
# pi39.save

# i40 = Ingredient.find_or_create_by(name: "Methylisothiazolinone")
# i40.como_rating = nil
# i40.save

# pi40 = ProductIngredient.create
# pi40.product_id = p2.id
# pi40.ingredient_id = i40.id
# pi40.save

# ###################

# p3 = Product.create
# p3.brand = "Cetaphil"
# p3.name = "Gentle Skin Cleanser"
# p3.category = "cleanser"
# p3.img_url = "https://s3-ap-southeast-1.amazonaws.com/skincarisma-staging/submitted_images/files/000/013/389/medium/cetaphil-gentle-skin-cleanser.jpg?1521899667"
# p3.sunscreen_type = nil
# p3.spf = nil
# p3.pa = nil
# p3.save

# up3 = UserProduct.create
# up3.user_id = 13
# up3.product_id = p3.id
# up3.current = false
# up3.rating = 1
# up3.wishlist = false
# up3.opened = nil
# up3.expires = nil
# up3.caused_acne = true
# up3.notes = "Caused cystic acne breakout."
# up3.save

# i1 = Ingredient.find_or_create_by(name: "Water")
# i1.como_rating = nil
# i1.save

# pi1 = ProductIngredient.create
# pi1.product_id = p3.id
# pi1.ingredient_id = i1.id
# pi1.save

# i2 = Ingredient.find_or_create_by(name: "Cetyl Alcohol")
# i2.como_rating = 2
# i2.save

# pi2 = ProductIngredient.create
# pi2.product_id = p3.id
# pi2.ingredient_id = i2.id
# pi2.save

# i3 = Ingredient.find_or_create_by(name: "Propylene Glycol")
# i3.como_rating = nil
# i3.save

# pi3 = ProductIngredient.create
# pi3.product_id = p3.id
# pi3.ingredient_id = i3.id
# pi3.save

# i4 = Ingredient.find_or_create_by(name: "Sodium Lauryl Sulfate")
# i4.como_rating = nil
# i4.save

# pi4 = ProductIngredient.create
# pi4.product_id = p3.id
# pi4.ingredient_id = i4.id
# pi4.save

# i5 = Ingredient.find_or_create_by(name: "Stearyl Alcohol")
# i5.como_rating = 2
# i5.save

# pi5 = ProductIngredient.create
# pi5.product_id = p3.id
# pi5.ingredient_id = i5.id
# pi5.save

# i6 = Ingredient.find_or_create_by(name: "Methylparaben")
# i6.como_rating = nil
# i6.save

# pi6 = ProductIngredient.create
# pi6.product_id = p3.id
# pi6.ingredient_id = i6.id
# pi6.save

# i7 = Ingredient.find_or_create_by(name: "Propylparaben")
# i7.como_rating = 0
# i7.save

# pi7 = ProductIngredient.create
# pi7.product_id = p3.id
# pi7.ingredient_id = i7.id
# pi7.save

# i8 = Ingredient.find_or_create_by(name: "Butylparaben")
# i8.como_rating = nil
# i8.save

# pi8 = ProductIngredient.create
# pi8.product_id = p3.id
# pi8.ingredient_id = i8.id
# pi8.save

# ###################

# p4 = Product.create
# p4.brand = "Hada Labo"
# p4.name = "Gokujyun Perfect Gel"
# p4.category = "Moisturizer"
# p4.img_url = "https://cdn.shopify.com/s/files/1/1795/7013/products/4_3bff5922-c769-4be8-a8db-39ab1c4ad837_1200x.png?v=1522270844"
# p4.sunscreen_type = nil
# p4.spf = nil
# p4.pa = nil
# p4.save

# up4 = UserProduct.create
# up4.user_id = 13
# up4.product_id = p4.id
# up4.current = true
# up4.rating = 5
# up4.wishlist = false
# up4.opened = nil
# up4.expires = nil
# up4.caused_acne = false
# up4.notes = "Holy Grail Moisturizer!"
# up4.save

# i1 = Ingredient.find_or_create_by(name: "Water")
# i1.como_rating = nil
# i1.save

# pi1 = ProductIngredient.create
# pi1.product_id = p4.id
# pi1.ingredient_id = i1.id
# pi1.save

# i2 = Ingredient.find_or_create_by(name: "Butylene Glycol")
# i2.como_rating = 1
# i2.save

# pi2 = ProductIngredient.create
# pi2.product_id = p4.id
# pi2.ingredient_id = i2.id
# pi2.save

# i3 = Ingredient.find_or_create_by(name: "Hydroxyethyl Urea")
# i3.como_rating = nil
# i3.save

# pi3 = ProductIngredient.create
# pi3.product_id = p4.id
# pi3.ingredient_id = i3.id
# pi3.save

# i4 = Ingredient.find_or_create_by(name: "Pentylene Glycol")
# i4.como_rating = nil
# i4.save

# pi4 = ProductIngredient.create
# pi4.product_id = p4.id
# pi4.ingredient_id = i4.id
# pi4.save

# i5 = Ingredient.find_or_create_by(name: "Glycerin")
# i5.como_rating = 0
# i5.save

# pi5 = ProductIngredient.create
# pi5.product_id = p4.id
# pi5.ingredient_id = i5.id
# pi5.save

# i6 = Ingredient.find_or_create_by(name: "Squalane")
# i6.como_rating = 1
# i6.save

# pi6 = ProductIngredient.create
# pi6.product_id = p4.id
# pi6.ingredient_id = i6.id
# pi6.save

# i7 = Ingredient.find_or_create_by(name: "PEG/PPG/Polybutylene Glycol-8/5/3 Glycerin")
# i7.como_rating = nil
# i7.save

# pi7 = ProductIngredient.create
# pi7.product_id = p4.id
# pi7.ingredient_id = i7.id
# pi7.save

# i8 = Ingredient.find_or_create_by(name: "Triethylhexanoin")
# i8.como_rating = nil
# i8.save

# pi8 = ProductIngredient.create
# pi8.product_id = p4.id
# pi8.ingredient_id = i8.id
# pi8.save

# i9 = Ingredient.find_or_create_by(name: "Ammonium Acryloyldimethyltaurate/VP Copolymer")
# i9.como_rating = nil
# i9.save

# pi9 = ProductIngredient.create
# pi9.product_id = p4.id
# pi9.ingredient_id = i9.id
# pi9.save

# i10 = Ingredient.find_or_create_by(name: "Agar")
# i10.como_rating = nil
# i10.save

# pi10 = ProductIngredient.create
# pi10.product_id = p4.id
# pi10.ingredient_id = i10.id
# pi10.save

# i11 = Ingredient.find_or_create_by(name: "Arginine")
# i11.como_rating = nil
# i11.save

# pi11 = ProductIngredient.create
# pi11.product_id = p4.id
# pi11.ingredient_id = i11.id
# pi11.save

# i12 = Ingredient.find_or_create_by(name: "Dextrin")
# i12.como_rating = nil
# i12.save

# pi12 = ProductIngredient.create
# pi12.product_id = p4.id
# pi12.ingredient_id = i12.id
# pi12.save

# i13 = Ingredient.find_or_create_by(name: "Dimethicone")
# i13.como_rating = 1
# i13.save

# pi13 = ProductIngredient.create
# pi13.product_id = p4.id
# pi13.ingredient_id = i13.id
# pi13.save

# i14 = Ingredient.find_or_create_by(name: "Disodium EDTA")
# i14.como_rating = nil
# i14.save

# pi14 = ProductIngredient.create
# pi14.product_id = p4.id
# pi14.ingredient_id = i14.id
# pi14.save

# i15 = Ingredient.find_or_create_by(name: "Disodium Succinate")
# i15.como_rating = nil
# i15.save

# pi15 = ProductIngredient.create
# pi15.product_id = p4.id
# pi15.ingredient_id = i15.id
# pi15.save

# i16 = Ingredient.find_or_create_by(name: "Glucosyl Ceramide")
# i16.como_rating = nil
# i16.save

# pi16 = ProductIngredient.create
# pi16.product_id = p4.id
# pi16.ingredient_id = i16.id
# pi16.save

# i17 = Ingredient.find_or_create_by(name: "Hydrolyzed Collagen")
# i17.como_rating = 0
# i17.save

# pi17 = ProductIngredient.create
# pi17.product_id = p4.id
# pi17.ingredient_id = i17.id
# pi17.save

# i18 = Ingredient.find_or_create_by(name: "Hydrolyzed Hyaluronic Acid")
# i18.como_rating = nil
# i18.save

# pi18 = ProductIngredient.create
# pi18.product_id = p4.id
# pi18.ingredient_id = i18.id
# pi18.save

# i19 = Ingredient.find_or_create_by(name: "Methylparaben")
# i19.como_rating = 0
# i19.save

# pi19 = ProductIngredient.create
# pi19.product_id = p4.id
# pi19.ingredient_id = i19.id
# pi19.save

# i20 = Ingredient.find_or_create_by(name: "Phenoxyethanol")
# i20.como_rating = nil
# i20.save

# pi20 = ProductIngredient.create
# pi20.product_id = p4.id
# pi20.ingredient_id = i20.id
# pi20.save

# i21 = Ingredient.find_or_create_by(name: "Propylparaben")
# i21.como_rating = 0
# i21.save

# pi21 = ProductIngredient.create
# pi21.product_id = p4.id
# pi21.ingredient_id = i21.id
# pi21.save

# i22 = Ingredient.find_or_create_by(name: "Sodium Acetylated Hyaluronate")
# i22.como_rating = nil
# i22.save

# pi22 = ProductIngredient.create
# pi22.product_id = p4.id
# pi22.ingredient_id = i22.id
# pi22.save

# i23 = Ingredient.find_or_create_by(name: "Sodium Hyaluronate")
# i23.como_rating = 0
# i23.save

# pi23 = ProductIngredient.create
# pi23.product_id = p4.id
# pi23.ingredient_id = i23.id
# pi23.save

# i24 = Ingredient.find_or_create_by(name: "Succinic Acid")
# i24.como_rating = nil
# i24.save

# pi24 = ProductIngredient.create
# pi24.product_id = p4.id
# pi24.ingredient_id = i24.id
# pi24.save

# i25 = Ingredient.find_or_create_by(name: "Triethyl Citrate")
# i25.como_rating = nil
# i25.save

# pi25 = ProductIngredient.create
# pi25.product_id = p4.id
# pi25.ingredient_id = i25.id
# pi25.save

# ###################

# p5 = Product.create
# p5.brand = "Stridex"
# p5.name = "Maximum"
# p5.category = "Active"
# p5.img_url = "https://pics.drugstore.com/prodimg/151226/900.jpg"
# p5.sunscreen_type = nil
# p5.spf = nil
# p5.pa = nil
# p5.save

# up5 = UserProduct.create
# up5.user_id = 13
# up5.product_id = p5.id
# up5.current = false
# up5.rating = 4 
# up5.wishlist = false
# up5.opened = nil
# up5.expires = nil
# up5.caused_acne = false
# up5.notes = "Drying but effective."
# up5.save

# i1 = Ingredient.find_or_create_by(name: "Salicylic Acid, 2%")
# i1.como_rating = nil
# i1.save

# pi1 = ProductIngredient.create
# pi1.product_id = p5.id
# pi1.ingredient_id = i1.id
# pi1.save

# i2 = Ingredient.find_or_create_by(name: "Aminomethyl Propanol")
# i2.como_rating = nil
# i2.save

# pi2 = ProductIngredient.create
# pi2.product_id = p5.id
# pi2.ingredient_id = i2.id
# pi2.save

# i3 = Ingredient.find_or_create_by(name: "Ammonium Xylenesulfonate")
# i3.como_rating = nil
# i3.save

# pi3 = ProductIngredient.create
# pi3.product_id = p5.id
# pi3.ingredient_id = i3.id
# pi3.save

# i4 = Ingredient.find_or_create_by(name: "Citric Acid")
# i4.como_rating = nil
# i4.save

# pi4 = ProductIngredient.create
# pi4.product_id = p5.id
# pi4.ingredient_id = i4.id
# pi4.save

# i5 = Ingredient.find_or_create_by(name: "DMDM Hydantoin")
# i5.como_rating = nil
# i5.save

# pi5 = ProductIngredient.create
# pi5.product_id = p5.id
# pi5.ingredient_id = i5.id
# pi5.save

# i6 = Ingredient.find_or_create_by(name: "Fragrance")
# i6.como_rating = nil
# i6.save

# pi6 = ProductIngredient.create
# pi6.product_id = p5.id
# pi6.ingredient_id = i6.id
# pi6.save

# i7 = Ingredient.find_or_create_by(name: "Menthol")
# i7.como_rating = nil
# i7.save

# pi7 = ProductIngredient.create
# pi7.product_id = p5.id
# pi7.ingredient_id = i7.id
# pi7.save

# i8 = Ingredient.find_or_create_by(name: "PPG-5-Ceteth-20")
# i8.como_rating = nil
# i8.save

# pi8 = ProductIngredient.create
# pi8.product_id = p5.id
# pi8.ingredient_id = i8.id
# pi8.save

# i9 = Ingredient.find_or_create_by(name: "Water")
# i9.como_rating = nil
# i9.save

# pi9 = ProductIngredient.create
# pi9.product_id = p5.id
# pi9.ingredient_id = i9.id
# pi9.save

# i10 = Ingredient.find_or_create_by(name: "Simethicone")
# i10.como_rating = 1
# i10.save

# pi10 = ProductIngredient.create
# pi10.product_id = p5.id
# pi10.ingredient_id = i10.id
# pi10.save

# i11 = Ingredient.find_or_create_by(name: "Sodium Borate")
# i11.como_rating = nil
# i11.save

# pi11 = ProductIngredient.create
# pi11.product_id = p5.id
# pi11.ingredient_id = i11.id
# pi11.save

# i12 = Ingredient.find_or_create_by(name: "Tetrasodium EDTA")
# i12.como_rating = nil
# i12.save

# pi12 = ProductIngredient.create
# pi12.product_id = p5.id
# pi12.ingredient_id = i12.id
# pi12.save

# ###################

# p6 = Product.create
# p6.brand = "Canmake"
# p6.name = "Mermaid Skin Gel UV SPF50+ PA++++"
# p6.category = "sunscreen"
# p6.img_url = "https://s3-ap-southeast-1.amazonaws.com/skincarisma-staging/submitted_images/files/000/049/306/medium/mermaid-skin-gel-uv-spf50-pa.jpg?1549908900"
# p6.sunscreen_type = "chemical"
# p6.spf = "50"
# p6.pa = "++++"
# p6.save

# up6 = UserProduct.create
# up6.user_id = 13
# up6.product_id = p6.id
# up6.current = false
# up6.rating = 4
# up6.wishlist = false
# up6.opened = nil
# up6.expires = nil
# up6.caused_acne = true
# up6.notes = "Perfect consistency, but caused acne."
# up6.save

# i1 = Ingredient.find_or_create_by(name: "Water")
# i1.como_rating = nil
# i1.save

# pi1 = ProductIngredient.create
# pi1.product_id = p6.id
# pi1.ingredient_id = i1.id
# pi1.save

# i2 = Ingredient.find_or_create_by(name: "Ethylhexyl Methoxycinnamate")
# i2.como_rating = 0
# i2.save

# pi2 = ProductIngredient.create
# pi2.product_id = p6.id
# pi2.ingredient_id = i2.id
# pi2.save

# i3 = Ingredient.find_or_create_by(name: "Butylene Glycol")
# i3.como_rating = 1
# i3.save

# pi3 = ProductIngredient.create
# pi3.product_id = p6.id
# pi3.ingredient_id = i3.id
# pi3.save

# i4 = Ingredient.find_or_create_by(name: "Diethylamino Hydroxybenzoyl Hexyl Benzoate")
# i4.como_rating = nil
# i4.save

# pi4 = ProductIngredient.create
# pi4.product_id = p6.id
# pi4.ingredient_id = i4.id
# pi4.save

# i5 = Ingredient.find_or_create_by(name: "Zinc Oxide")
# i5.como_rating = 1
# i5.save

# pi5 = ProductIngredient.create
# pi5.product_id = p6.id
# pi5.ingredient_id = i5.id
# pi5.save

# i6 = Ingredient.find_or_create_by(name: "Methylheptyl Isostearate")
# i6.como_rating = nil
# i6.save

# pi6 = ProductIngredient.create
# pi6.product_id = p6.id
# pi6.ingredient_id = i6.id
# pi6.save

# i7 = Ingredient.find_or_create_by(name: "Titanium Dioxide")
# i7.como_rating = 0
# i7.save

# pi7 = ProductIngredient.create
# pi7.product_id = p6.id
# pi7.ingredient_id = i7.id
# pi7.save

# i8 = Ingredient.find_or_create_by(name: "Dimethicone")
# i8.como_rating = 1
# i8.save

# pi8 = ProductIngredient.create
# pi8.product_id = p6.id
# pi8.ingredient_id = i8.id
# pi8.save

# i9 = Ingredient.find_or_create_by(name: "Bis-Ethylhexyloxyphenol Methoxyphenyl Triazine")
# i9.como_rating = nil
# i9.save

# pi9 = ProductIngredient.create
# pi9.product_id = p6.id
# pi9.ingredient_id = i9.id
# pi9.save

# i10 = Ingredient.find_or_create_by(name: "Polymethylsilsesquioxane")
# i10.como_rating = nil
# i10.save

# pi10 = ProductIngredient.create
# pi10.product_id = p6.id
# pi10.ingredient_id = i10.id
# pi10.save

# i11 = Ingredient.find_or_create_by(name: "Cyclopentasiloxane")
# i11.como_rating = nil
# i11.save

# pi11 = ProductIngredient.create
# pi11.product_id = p6.id
# pi11.ingredient_id = i11.id
# pi11.save

# i12 = Ingredient.find_or_create_by(name: "Acryloyldimethyltaurate/VP Copolymer")
# i12.como_rating = nil
# i12.save

# pi12 = ProductIngredient.create
# pi12.product_id = p6.id
# pi12.ingredient_id = i12.id
# pi12.save

# i13 = Ingredient.find_or_create_by(name: "Diisostearyl Malate")
# i13.como_rating = nil
# i13.save

# pi13 = ProductIngredient.create
# pi13.product_id = p6.id
# pi13.ingredient_id = i13.id
# pi13.save

# i14 = Ingredient.find_or_create_by(name: "Aluminum Hydroxide")
# i14.como_rating = nil
# i14.save

# pi14 = ProductIngredient.create
# pi14.product_id = p6.id
# pi14.ingredient_id = i14.id
# pi14.save

# i15 = Ingredient.find_or_create_by(name: "PEG-60 Hydrogenated Castor Oil")
# i15.como_rating = nil
# i15.save

# pi15 = ProductIngredient.create
# pi15.product_id = p6.id
# pi15.ingredient_id = i15.id
# pi15.save

# i16 = Ingredient.find_or_create_by(name: "Stearic Acid")
# i16.como_rating = 3
# i16.save

# pi16 = ProductIngredient.create
# pi16.product_id = p6.id
# pi16.ingredient_id = i16.id
# pi16.save

# i17 = Ingredient.find_or_create_by(name: "Phenoxyethanol")
# i17.como_rating = nil
# i17.save

# pi17 = ProductIngredient.create
# pi17.product_id = p6.id
# pi17.ingredient_id = i17.id
# pi17.save

# i18 = Ingredient.find_or_create_by(name: "Polyglyceryl-3 Polydimethylsiloxyethyl Dimethicone")
# i18.como_rating = nil
# i18.save

# pi18 = ProductIngredient.create
# pi18.product_id = p6.id
# pi18.ingredient_id = i18.id
# pi18.save

# i19 = Ingredient.find_or_create_by(name: "Polyhydroxystearic Acid")
# i19.como_rating = nil
# i19.save

# pi19 = ProductIngredient.create
# pi19.product_id = p6.id
# pi19.ingredient_id = i19.id
# pi19.save

# i20 = Ingredient.find_or_create_by(name: "Jojoba Esters")
# i20.como_rating = nil
# i20.save

# pi20 = ProductIngredient.create
# pi20.product_id = p6.id
# pi20.ingredient_id = i20.id
# pi20.save

# i21 = Ingredient.find_or_create_by(name: "Xanthan Gum")
# i21.como_rating = nil
# i21.save

# pi21 = ProductIngredient.create
# pi21.product_id = p6.id
# pi21.ingredient_id = i21.id
# pi21.save

# i22 = Ingredient.find_or_create_by(name: "Arginine")
# i22.como_rating = nil
# i22.save

# pi22 = ProductIngredient.create
# pi22.product_id = p6.id
# pi22.ingredient_id = i22.id
# pi22.save

# i23 = Ingredient.find_or_create_by(name: "Hyaluronic Acid")
# i23.como_rating = nil
# i23.save

# pi23 = ProductIngredient.create
# pi23.product_id = p6.id
# pi23.ingredient_id = i23.id
# pi23.save

# i24 = Ingredient.find_or_create_by(name: "Alpha-Glucan")
# i24.como_rating = nil
# i24.save

# pi24 = ProductIngredient.create
# pi24.product_id = p6.id
# pi24.ingredient_id = i24.id
# pi24.save

# i25 = Ingredient.find_or_create_by(name: "Phytic Acid")
# i25.como_rating = nil
# i25.save

# pi25 = ProductIngredient.create
# pi25.product_id = p6.id
# pi25.ingredient_id = i25.id
# pi25.save

# i26 = Ingredient.find_or_create_by(name: "Saxifraga Sarmentosa Extract")
# i26.como_rating = nil
# i26.save

# pi26 = ProductIngredient.create
# pi26.product_id = p6.id
# pi26.ingredient_id = i26.id
# pi26.save

# i27 = Ingredient.find_or_create_by(name: "Glucosyl Ceramide")
# i27.como_rating = nil
# i27.save

# pi27 = ProductIngredient.create
# pi27.product_id = p6.id
# pi27.ingredient_id = i27.id
# pi27.save

# i28 = Ingredient.find_or_create_by(name: "Prunus Yedoensis Leaf Extract")
# i28.como_rating = nil
# i28.save

# pi28 = ProductIngredient.create
# pi28.product_id = p6.id
# pi28.ingredient_id = i28.id
# pi28.save

# i29 = Ingredient.find_or_create_by(name: "Coix Lacryma-Jobi Ma-yuen (Job's Tears)")
# i29.como_rating = nil
# i29.save

# pi29 = ProductIngredient.create
# pi29.product_id = p6.id
# pi29.ingredient_id = i29.id
# pi29.save

# i30 = Ingredient.find_or_create_by(name: "Morus Alba Root Extract")
# i30.como_rating = nil
# i30.save

# pi30 = ProductIngredient.create
# pi30.product_id = p6.id
# pi30.ingredient_id = i30.id
# pi30.save

# i31 = Ingredient.find_or_create_by(name: "Oenothera Biennis (Evening Primrose) Seed Extract")
# i31.como_rating = nil
# i31.save

# pi31 = ProductIngredient.create
# pi31.product_id = p6.id
# pi31.ingredient_id = i31.id
# pi31.save

# i32 = Ingredient.find_or_create_by(name: "Silver Oxide")
# i32.como_rating = nil
# i32.save

# pi32 = ProductIngredient.create
# pi32.product_id = p6.id
# pi32.ingredient_id = i32.id
# pi32.save

# i33 = Ingredient.find_or_create_by(name: "Spiraea Ulmaria Flower Extract")
# i33.como_rating = nil
# i33.save

# pi33 = ProductIngredient.create
# pi33.product_id = p6.id
# pi33.ingredient_id = i33.id
# pi33.save

# i34 = Ingredient.find_or_create_by(name: "Vaccinium Myrtillus (Bilberry) Extract")
# i34.como_rating = nil
# i34.save

# pi34 = ProductIngredient.create
# pi34.product_id = p6.id
# pi34.ingredient_id = i34.id
# pi34.save

# i35 = Ingredient.find_or_create_by(name: "Cynara Scolymus (Artichoke) Leaf Extract")
# i35.como_rating = nil
# i35.save

# pi35 = ProductIngredient.create
# pi35.product_id = p6.id
# pi35.ingredient_id = i35.id
# pi35.save

# ###################

# p7 = Product.create
# p7.brand = "Banila Co."
# p7.name = "Clean It Zero"
# p7.category = "cleanser"
# p7.img_url = "https://s3-ap-southeast-1.amazonaws.com/skincarisma-staging/submitted_images/files/000/050/083/medium/clean-it-zero-classic.jpg?1549911801"
# p7.sunscreen_type = nil
# p7.spf = nil
# p7.pa = nil
# p7.save

# up7 = UserProduct.create
# up7.user_id = 13
# up7.product_id = p7.id
# up7.current = false
# up7.rating = 5
# up7.wishlist = false
# up7.opened = nil
# up7.expires =  nil
# up7.caused_acne = false
# up7.notes = nil
# up7.save

# i1 = Ingredient.find_or_create_by(name: "Mineral Oil")
# i1.como_rating = 2
# i1.save

# pi1 = ProductIngredient.create
# pi1.product_id = p7.id
# pi1.ingredient_id = i1.id
# pi1.save

# i2 = Ingredient.find_or_create_by(name: "Cetyl Ethylhexanoate")
# i2.como_rating = nil
# i2.save

# pi2 = ProductIngredient.create
# pi2.product_id = p7.id
# pi2.ingredient_id = i2.id
# pi2.save

# i3 = Ingredient.find_or_create_by(name: "PEG-20 Glyceryl Triisostearate")
# i3.como_rating = nil
# i3.save

# pi3 = ProductIngredient.create
# pi3.product_id = p7.id
# pi3.ingredient_id = i3.id
# pi3.save

# i4 = Ingredient.find_or_create_by(name: "PEG-10 Isostearate")
# i4.como_rating = nil
# i4.save

# pi4 = ProductIngredient.create
# pi4.product_id = p7.id
# pi4.ingredient_id = i4.id
# pi4.save

# i5 = Ingredient.find_or_create_by(name: "Polyethylene")
# i5.como_rating = nil
# i5.save

# pi5 = ProductIngredient.create
# pi5.product_id = p7.id
# pi5.ingredient_id = i5.id
# pi5.save

# i6 = Ingredient.find_or_create_by(name: "Butylene Glycol")
# i6.como_rating = 1
# i6.save

# pi6 = ProductIngredient.create
# pi6.product_id = p7.id
# pi6.ingredient_id = i6.id
# pi6.save

# i7 = Ingredient.find_or_create_by(name: "Water")
# i7.como_rating = nil
# i7.save

# pi7 = ProductIngredient.create
# pi7.product_id = p7.id
# pi7.ingredient_id = i7.id
# pi7.save

# i8 = Ingredient.find_or_create_by(name: "Rubus Suavissimus (Raspberry) Leaf Extract")
# i8.como_rating = nil
# i8.save

# pi8 = ProductIngredient.create
# pi8.product_id = p7.id
# pi8.ingredient_id = i8.id
# pi8.save

# i9 = Ingredient.find_or_create_by(name: "Bambusa Arundinacea Stem Extract")
# i9.como_rating = nil
# i9.save

# pi9 = ProductIngredient.create
# pi9.product_id = p7.id
# pi9.ingredient_id = i9.id
# pi9.save

# i10 = Ingredient.find_or_create_by(name: "Aspalathus Linearis Leaf Extract")
# i10.como_rating = nil
# i10.save

# pi10 = ProductIngredient.create
# pi10.product_id = p7.id
# pi10.ingredient_id = i10.id
# pi10.save

# i11 = Ingredient.find_or_create_by(name: "Viscum Album (Mistletoe) Leaf Extract")
# i11.como_rating = nil
# i11.save

# pi11 = ProductIngredient.create
# pi11.product_id = p7.id
# pi11.ingredient_id = i11.id
# pi11.save

# i12 = Ingredient.find_or_create_by(name: "Angelica Polymorpha Sinensis Root Extract")
# i12.como_rating = nil
# i12.save

# pi12 = ProductIngredient.create
# pi12.product_id = p7.id
# pi12.ingredient_id = i12.id
# pi12.save

# i13 = Ingredient.find_or_create_by(name: "Carica Papaya (Papaya) Fruit Extract")
# i13.como_rating = nil
# i13.save

# pi13 = ProductIngredient.create
# pi13.product_id = p7.id
# pi13.ingredient_id = i13.id
# pi13.save

# i14 = Ingredient.find_or_create_by(name: "Malpighia Glabra (Acerola) Fruit Extract")
# i14.como_rating = nil
# i14.save

# pi14 = ProductIngredient.create
# pi14.product_id = p7.id
# pi14.ingredient_id = i14.id
# pi14.save

# i15 = Ingredient.find_or_create_by(name: "Epilobium Angustifolium Leaf Extract")
# i15.como_rating = nil
# i15.save

# pi15 = ProductIngredient.create
# pi15.product_id = p7.id
# pi15.ingredient_id = i15.id
# pi15.save

# i16 = Ingredient.find_or_create_by(name: "BHT")
# i16.como_rating = nil
# i16.save

# pi16 = ProductIngredient.create
# pi16.product_id = p7.id
# pi16.ingredient_id = i16.id
# pi16.save

# i17 = Ingredient.find_or_create_by(name: "Butylparaben")
# i17.como_rating = nil
# i17.save

# pi17 = ProductIngredient.create
# pi17.product_id = p7.id
# pi17.ingredient_id = i17.id
# pi17.save

# i18 = Ingredient.find_or_create_by(name: "CI 16255")
# i18.como_rating = nil
# i18.save

# pi18 = ProductIngredient.create
# pi18.product_id = p7.id
# pi18.ingredient_id = i18.id
# pi18.save

# i19 = Ingredient.find_or_create_by(name: "CI 15985")
# i19.como_rating = nil
# i19.save

# pi19 = ProductIngredient.create
# pi19.product_id = p7.id
# pi19.ingredient_id = i19.id
# pi19.save

# i20 = Ingredient.find_or_create_by(name: "Fragrance")
# i20.como_rating = nil
# i20.save

# pi20 = ProductIngredient.create
# pi20.product_id = p7.id
# pi20.ingredient_id = i20.id
# pi20.save

# ###################

# p8 = Product.create
# p8.brand = "Blue Lizard"
# p8.name = "Face"
# p8.category = "Sunscreen"
# p8.img_url = "https://i5.walmartimages.com/asr/a5cece97-f266-49c9-9fdf-d0aec3b51895_1.462e41e61a5ce3f49bc44f9c57321269.jpeg?odnWidth=450&odnHeight=450&odnBg=ffffff"
# p8.sunscreen_type = "chemical"
# p8.spf = "30+"
# p8.pa = nil
# p8.save

# i1 = Ingredient.find_or_create_by(name: "Cinoxate")
# i1.como_rating = nil
# i1.save

# pi1 = ProductIngredient.create
# pi1.product_id = p8.id
# pi1.ingredient_id = i1.id
# pi1.save

# i2 = Ingredient.find_or_create_by(name: "Zinc Oxide")
# i2.como_rating = 1
# i2.save

# pi2 = ProductIngredient.create
# pi2.product_id = p8.id
# pi2.ingredient_id = i2.id
# pi2.save

# i3 = Ingredient.find_or_create_by(name: "Water")
# i3.como_rating = nil
# i3.save

# pi3 = ProductIngredient.create
# pi3.product_id = p8.id
# pi3.ingredient_id = i3.id
# pi3.save

# i4 = Ingredient.find_or_create_by(name: "C12-15 Alkyl Benzoate")
# i4.como_rating = nil
# i4.save

# pi4 = ProductIngredient.create
# pi4.product_id = p8.id
# pi4.ingredient_id = i4.id
# pi4.save

# i5 = Ingredient.find_or_create_by(name: "Cyclomethicone")
# i5.como_rating = 1
# i5.save

# pi5 = ProductIngredient.create
# pi5.product_id = p8.id
# pi5.ingredient_id = i5.id
# pi5.save

# i6 = Ingredient.find_or_create_by(name: "Lauryl PEG/PPG-18/18 Methicone")
# i6.como_rating = nil
# i6.save

# pi6 = ProductIngredient.create
# pi6.product_id = p8.id
# pi6.ingredient_id = i6.id
# pi6.save

# i7 = Ingredient.find_or_create_by(name: "Polyacrylamide")
# i7.como_rating = nil
# i7.save

# pi7 = ProductIngredient.create
# pi7.product_id = p8.id
# pi7.ingredient_id = i7.id
# pi7.save

# i8 = Ingredient.find_or_create_by(name: "C13-14 Isoparaffin")
# i8.como_rating = nil
# i8.save

# pi8 = ProductIngredient.create
# pi8.product_id = p8.id
# pi8.ingredient_id = i8.id
# pi8.save

# i9 = Ingredient.find_or_create_by(name: "Laureth-7")
# i9.como_rating = nil
# i9.save

# pi9 = ProductIngredient.create
# pi9.product_id = p8.id
# pi9.ingredient_id = i9.id
# pi9.save

# i10 = Ingredient.find_or_create_by(name: "Tocopheryl Acetate (Vitamin E)")
# i10.como_rating = 0
# i10.save

# pi10 = ProductIngredient.create
# pi10.product_id = p8.id
# pi10.ingredient_id = i10.id
# pi10.save

# i11 = Ingredient.find_or_create_by(name: "Hyaluronic Acid")
# i11.como_rating = nil
# i11.save

# pi11 = ProductIngredient.create
# pi11.product_id = p8.id
# pi11.ingredient_id = i11.id
# pi11.save

# i12 = Ingredient.find_or_create_by(name: "Camellia Sinensis (Green Tea) Leaf Extract")
# i12.como_rating = nil
# i12.save

# pi12 = ProductIngredient.create
# pi12.product_id = p8.id
# pi12.ingredient_id = i12.id
# pi12.save

# i13 = Ingredient.find_or_create_by(name: "PEG-8 Beeswax")
# i13.como_rating = nil
# i13.save

# pi13 = ProductIngredient.create
# pi13.product_id = p8.id
# pi13.ingredient_id = i13.id
# pi13.save

# i14 = Ingredient.find_or_create_by(name: "Caffeine")
# i14.como_rating = nil
# i14.save

# pi14 = ProductIngredient.create
# pi14.product_id = p8.id
# pi14.ingredient_id = i14.id
# pi14.save

# i15 = Ingredient.find_or_create_by(name: "Diazolidinyl Urea")
# i15.como_rating = nil
# i15.save

# pi15 = ProductIngredient.create
# pi15.product_id = p8.id
# pi15.ingredient_id = i15.id
# pi15.save

# i16 = Ingredient.find_or_create_by(name: "Methylparaben")
# i16.como_rating = 0
# i16.save

# pi16 = ProductIngredient.create
# pi16.product_id = p8.id
# pi16.ingredient_id = i16.id
# pi16.save

# i17 = Ingredient.find_or_create_by(name: "Propylparaben")
# i17.como_rating = nil
# i17.save

# pi17 = ProductIngredient.create
# pi17.product_id = p8.id
# pi17.ingredient_id = i17.id
# pi17.save

# ###################

# p9 = Product.create
# p9.brand = "COSRX"
# p9.name = "Ultimate Moisturizing Honey Overnight Mask"
# p9.category = "mask"
# p9.img_url = "https://cdn10.bigcommerce.com/s-6dbw5r/products/361/images/1647/1a8ebcccf3c6dbfda81a23bd599e3839__92388.1537308871.400.400.jpg?c=2"
# p9.sunscreen_type = nil
# p9.spf = nil
# p9.pa = nil
# p9.save

# i1 = Ingredient.find_or_create_by(name: "Propolis Extract")
# i1.como_rating = nil
# i1.save

# pi1 = ProductIngredient.create
# pi1.product_id = p9.id
# pi1.ingredient_id = i1.id
# pi1.save

# i2 = Ingredient.find_or_create_by(name: "Butylene Glycol")
# i2.como_rating = 1
# i2.save

# pi2 = ProductIngredient.create
# pi2.product_id = p9.id
# pi2.ingredient_id = i2.id
# pi2.save

# i3 = Ingredient.find_or_create_by(name: "Glycerin")
# i3.como_rating = nil
# i3.save

# pi3 = ProductIngredient.create
# pi3.product_id = p9.id
# pi3.ingredient_id = i3.id
# pi3.save

# i4 = Ingredient.find_or_create_by(name: "Betaine")
# i4.como_rating = nil
# i4.save

# pi4 = ProductIngredient.create
# pi4.product_id = p9.id
# pi4.ingredient_id = i4.id
# pi4.save

# i5 = Ingredient.find_or_create_by(name: "1,2-Hexanediol")
# i5.como_rating = nil
# i5.save

# pi5 = ProductIngredient.create
# pi5.product_id = p9.id
# pi5.ingredient_id = i5.id
# pi5.save

# i6 = Ingredient.find_or_create_by(name: "PEG-60 Hydrogenated Castor Oil")
# i6.como_rating = nil
# i6.save

# pi6 = ProductIngredient.create
# pi6.product_id = p9.id
# pi6.ingredient_id = i6.id
# pi6.save

# i7 = Ingredient.find_or_create_by(name: "Arginine")
# i7.como_rating = nil
# i7.save

# pi7 = ProductIngredient.create
# pi7.product_id = p9.id
# pi7.ingredient_id = i7.id
# pi7.save

# i8 = Ingredient.find_or_create_by(name: "Cassia Obtusifolia Seed Extract")
# i8.como_rating = nil
# i8.save

# pi8 = ProductIngredient.create
# pi8.product_id = p9.id
# pi8.ingredient_id = i8.id
# pi8.save

# i9 = Ingredient.find_or_create_by(name: "Dimethicone")
# i9.como_rating = 1
# i9.save

# pi9 = ProductIngredient.create
# pi9.product_id = p9.id
# pi9.ingredient_id = i9.id
# pi9.save

# i10 = Ingredient.find_or_create_by(name: "Ethylhexylglycerin")
# i10.como_rating = nil
# i10.save

# pi10 = ProductIngredient.create
# pi10.product_id = p9.id
# pi10.ingredient_id = i10.id
# pi10.save

# i11 = Ingredient.find_or_create_by(name: "Carbomer")
# i11.como_rating = nil
# i11.save

# pi11 = ProductIngredient.create
# pi11.product_id = p9.id
# pi11.ingredient_id = i11.id
# pi11.save

# i12 = Ingredient.find_or_create_by(name: "Sodium Hyaluronate")
# i12.como_rating = nil
# i12.save

# pi12 = ProductIngredient.create
# pi12.product_id = p9.id
# pi12.ingredient_id = i12.id
# pi12.save

# i13 = Ingredient.find_or_create_by(name: "PEG-8 Beeswax")
# i13.como_rating = nil
# i13.save

# pi13 = ProductIngredient.create
# pi13.product_id = p9.id
# pi13.ingredient_id = i13.id
# pi13.save

# i14 = Ingredient.find_or_create_by(name: "Allantoin")
# i14.como_rating = nil
# i14.save

# pi14 = ProductIngredient.create
# pi14.product_id = p9.id
# pi14.ingredient_id = i14.id
# pi14.save

# i15 = Ingredient.find_or_create_by(name: "Panthenol")
# i15.como_rating = nil
# i15.save

# pi15 = ProductIngredient.create
# pi15.product_id = p9.id
# pi15.ingredient_id = i15.id
# pi15.save

# i16 = Ingredient.find_or_create_by(name: "Sodium Polyacrylate")
# i16.como_rating = nil
# i16.save

# pi16 = ProductIngredient.create
# pi16.product_id = p9.id
# pi16.ingredient_id = i16.id
# pi16.save

# i17 = Ingredient.find_or_create_by(name: "Adenosine")
# i17.como_rating = nil
# i17.save

# pi17 = ProductIngredient.create
# pi17.product_id = p9.id
# pi17.ingredient_id = i17.id
# pi17.save

# ###################

# p10 = Product.create
# p10.brand = "Queen Helene"
# p10.name = "Mint Julep Masque"
# p10.category = "XYZ"
# p10.img_url = "https://images-na.ssl-images-amazon.com/images/I/71RDIOVPNbL._SL1500_.jpg"
# p10.sunscreen_type = nil
# p10.spf = nil
# p10.pa = nil
# p10.save

# i1 = Ingredient.find_or_create_by(name: "Water")
# i1.como_rating = nil
# i1.save

# pi1 = ProductIngredient.create
# pi1.product_id = p10.id
# pi1.ingredient_id = i1.id
# pi1.save

# i2 = Ingredient.find_or_create_by(name: "Kaolin")
# i2.como_rating = 0
# i2.save

# pi2 = ProductIngredient.create
# pi2.product_id = p10.id
# pi2.ingredient_id = i2.id
# pi2.save

# i3 = Ingredient.find_or_create_by(name: "Bentonite")
# i3.como_rating = 0
# i3.save

# pi3 = ProductIngredient.create
# pi3.product_id = p10.id
# pi3.ingredient_id = i3.id
# pi3.save

# i4 = Ingredient.find_or_create_by(name: "Glycerin")
# i4.como_rating = 0
# i4.save

# pi4 = ProductIngredient.create
# pi4.product_id = p10.id
# pi4.ingredient_id = i4.id
# pi4.save

# i5 = Ingredient.find_or_create_by(name: "Chromium Oxide Greens")
# i5.como_rating = nil
# i5.save

# pi5 = ProductIngredient.create
# pi5.product_id = p10.id
# pi5.ingredient_id = i5.id
# pi5.save

# i6 = Ingredient.find_or_create_by(name: "Fragrance")
# i6.como_rating = nil
# i6.save

# pi6 = ProductIngredient.create
# pi6.product_id = p10.id
# pi6.ingredient_id = i6.id
# pi6.save

# i7 = Ingredient.find_or_create_by(name: "Phenoxyethanol")
# i7.como_rating = nil
# i7.save

# pi7 = ProductIngredient.create
# pi7.product_id = p10.id
# pi7.ingredient_id = i7.id
# pi7.save

# i8 = Ingredient.find_or_create_by(name: "Methylparaben")
# i8.como_rating = 0
# i8.save