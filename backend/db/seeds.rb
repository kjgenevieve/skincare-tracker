# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
Product.destroy_all
UserProduct.destroy_all
Ingredient.destroy_all
ProductIngredient.destroy_all

u1 = User.create
u1.name = "Genevieve"
u1.save

p1 = Product.create
p1.brand = "Neutrogena"
p1.name = "Oil-Free Acne Wash Pink Grapefruit Facial Cleanser"
p1.category = "cleanser"
p1.img_url = "https://target.scene7.com/is/image/Target/11537188?wid=520&hei=520&fmt=pjpeg"
p1.sunscreen_type = nil
p1.spf = nil
p1.pa = nil
p1.save

up1 = UserProduct.create
up1.user_id = 13
up1.product_id = p1.id
up1.current = false
up1.rating = 4
up1.wishlist = false
up1.opened = nil
up1.expires = nil
up1.caused_acne = false
up1.notes = "A little harsh and drying."
up1.save

i1 = Ingredient.find_or_create_by(name: "Salicylic Acid, 2%")
i1.como_rating = nil
i1.save

pi1 = ProductIngredient.create
pi1.product_id = p1.id
pi1.ingredient_id = i1.id
pi1.save

i2 = Ingredient.find_or_create_by(name: "Water")
i2.como_rating = nil
i2.save

pi2 = ProductIngredient.create
pi2.product_id = p1.id
pi2.ingredient_id = i2.id
pi2.save

i3 = Ingredient.find_or_create_by(name: "Sodium C14-16 Olefin Sulfonate")
i3.como_rating = nil
i3.save

pi3 = ProductIngredient.create
pi3.product_id = p1.id
pi3.ingredient_id = i3.id
pi3.save

i4 = Ingredient.find_or_create_by(name: "Cocamidopropyl Betaine")
i4.como_rating = nil
i4.save

pi4 = ProductIngredient.create
pi4.product_id = p1.id
pi4.ingredient_id = i4.id
pi4.save

i5 = Ingredient.find_or_create_by(name: "Sodium Chloride")
i5.como_rating = nil
i5.save

pi5 = ProductIngredient.create
pi5.product_id = p1.id
pi5.ingredient_id = i5.id
pi5.save

i6 = Ingredient.find_or_create_by(name: "PEG-120 Methyl Glucose Dioleate")
i6.como_rating = nil
i6.save

pi6 = ProductIngredient.create
pi6.product_id = p1.id
pi6.ingredient_id = i6.id
pi6.save

i7 = Ingredient.find_or_create_by(name: "Polysorbate 20")
i7.como_rating = 0
i7.save

pi7 = ProductIngredient.create
pi7.product_id = p1.id
pi7.ingredient_id = i7.id
pi7.save

i8 = Ingredient.find_or_create_by(name: "Linoleamidopropyl PG-Dimonium Chloride Phosphate")
i8.como_rating = nil
i8.save

pi8 = ProductIngredient.create
pi8.product_id = p1.id
pi8.ingredient_id = i8.id
pi8.save

i9 = Ingredient.find_or_create_by(name: "Propylene Glycol")
i9.como_rating = 0
i9.save

pi9 = ProductIngredient.create
pi9.product_id = p1.id
pi9.ingredient_id = i9.id
pi9.save

i10 = Ingredient.find_or_create_by(name: "PEG-80 Sorbitan Laurate")
i10.como_rating = nil
i10.save

pi10 = ProductIngredient.create
pi10.product_id = p1.id
pi10.ingredient_id = i10.id
pi10.save

i11 = Ingredient.find_or_create_by(name: "Fragrance")
i11.como_rating = nil
i11.save

pi11 = ProductIngredient.create
pi11.product_id = p1.id
pi11.ingredient_id = i11.id
pi11.save

i12 = Ingredient.find_or_create_by(name: "Disodium EDTA")
i12.como_rating = nil
i12.save

pi12 = ProductIngredient.create
pi12.product_id = p1.id
pi12.ingredient_id = i12.id
pi12.save

i13 = Ingredient.find_or_create_by(name: "Benzalkonium Chloride")
i13.como_rating = nil
i13.save

pi13 = ProductIngredient.create
pi13.product_id = p1.id
pi13.ingredient_id = i13.id
pi13.save

i14 = Ingredient.find_or_create_by(name: "C12-15 Alkyl Lactate")
i14.como_rating = nil
i14.save

pi14 = ProductIngredient.create
pi14.product_id = p1.id
pi14.ingredient_id = i14.id
pi14.save

i15 = Ingredient.find_or_create_by(name: "Polyquaternium-7")
i15.como_rating = nil
i15.save

pi15 = ProductIngredient.create
pi15.product_id = p1.id
pi15.ingredient_id = i15.id
pi15.save

i16 = Ingredient.find_or_create_by(name: "Sodium Benzotriazolyl Butylphenol Sulfonate")
i16.como_rating = nil
i16.save

pi16 = ProductIngredient.create
pi16.product_id = p1.id
pi16.ingredient_id = i16.id
pi16.save

i17 = Ingredient.find_or_create_by(name: "Cocamidopropyl PG-Dimonium Chloride Phosphate")
i17.como_rating = nil
i17.save

pi17 = ProductIngredient.create
pi17.product_id = p1.id
pi17.ingredient_id = i17.id
pi17.save

i18 = Ingredient.find_or_create_by(name: "Ascorbyl Palmitate")
i18.como_rating = 2
i18.save

pi18 = ProductIngredient.create
pi18.product_id = p1.id
pi18.ingredient_id = i18.id
pi18.save

i19 = Ingredient.find_or_create_by(name: "Aloe Barbadensis Leaf Extract")
i19.como_rating = nil
i19.save

pi19 = ProductIngredient.create
pi19.product_id = p1.id
pi19.ingredient_id = i19.id
pi19.save

i20 = Ingredient.find_or_create_by(name: "Anthemis Nobilis Flower Extract")
i20.como_rating = nil
i20.save

pi20 = ProductIngredient.create
pi20.product_id = p1.id
pi20.ingredient_id = i20.id
pi20.save

i21 = Ingredient.find_or_create_by(name: "Chamomilla Recutita Flower Extract")
i21.como_rating = nil
i21.save

pi21 = ProductIngredient.create
pi21.product_id = p1.id
pi21.ingredient_id = i21.id
pi21.save

i22 = Ingredient.find_or_create_by(name: "Citrus Grandis Fruit Extract")
i22.como_rating = nil
i22.save

pi22 = ProductIngredient.create
pi22.product_id = p1.id
pi22.ingredient_id = i22.id
pi22.save

i23 = Ingredient.find_or_create_by(name: "Citric Acid")
i23.como_rating = nil
i23.save

pi23 = ProductIngredient.create
pi23.product_id = p1.id
pi23.ingredient_id = i23.id
pi23.save

i24 = Ingredient.find_or_create_by(name: "Sodium Hydroxide")
i24.como_rating = nil
i24.save

pi24 = ProductIngredient.create
pi24.product_id = p1.id
pi24.ingredient_id = i24.id
pi24.save

i25 = Ingredient.find_or_create_by(name: "Red 40")
i25.como_rating = nil
i25.save

pi25 = ProductIngredient.create
pi25.product_id = p1.id
pi25.ingredient_id = i25.id
pi25.save

i26 = Ingredient.find_or_create_by(name: "Violet 2")
i26.como_rating = nil
i26.save

pi26 = ProductIngredient.create
pi26.product_id = p1.id
pi26.ingredient_id = i26.id
pi26.save

###################

p2 = Product.create
p2.brand = "Tula"
p2.name = "Purifying Face Cleanser"
p2.category = "cleanser"
p2.img_url = "https://images.ulta.com/is/image/Ulta/2532485?op_sharpen=1&resMode=bilin&qlt=85&wid=800&hei=800&fmt=webp"
p2.sunscreen_type = nil
p2.spf = nil
p2.pa = nil
p2.save

up2 = UserProduct.create
up2.user_id = 13
up2.product_id = p2.id
up2.current = true
up2.rating = 5 
up2.wishlist = false
up2.opened = nil
up2.expires = nil
up2.caused_acne = false
up2.notes = "Holy Grail Cleanser!"
up2.save

i1 = Ingredient.find_or_create_by(name: "Eau")
i1.como_rating = nil
i1.save

pi1 = ProductIngredient.create
pi1.product_id = p2.id
pi1.ingredient_id = i1.id
pi1.save

i2 = Ingredient.find_or_create_by(name: "Cocamidopropyl Betaine")
i2.como_rating = nil
i2.save

pi2 = ProductIngredient.create
pi2.product_id = p2.id
pi2.ingredient_id = i2.id
pi2.save

i3 = Ingredient.find_or_create_by(name: "PEG-80 Sorbitan Laurate")
i3.como_rating = nil
i3.save

pi3 = ProductIngredient.create
pi3.product_id = p2.id
pi3.ingredient_id = i3.id
pi3.save

i4 = Ingredient.find_or_create_by(name: "Sodium Trideceth Sulfate")
i4.como_rating = nil
i4.save

pi4 = ProductIngredient.create
pi4.product_id = p2.id
pi4.ingredient_id = i4.id
pi4.save

i5 = Ingredient.find_or_create_by(name: "Lauryl Glucoside")
i5.como_rating = nil
i5.save

pi5 = ProductIngredient.create
pi5.product_id = p2.id
pi5.ingredient_id = i5.id
pi5.save

i6 = Ingredient.find_or_create_by(name: "Glycerin")
i6.como_rating = 0
i6.save

pi6 = ProductIngredient.create
pi6.product_id = p2.id
pi6.ingredient_id = i6.id
pi6.save

i7 = Ingredient.find_or_create_by(name: "PEG 150 Distearate")
i7.como_rating = 2
i7.save

pi7 = ProductIngredient.create
pi7.product_id = p2.id
pi7.ingredient_id = i7.id
pi7.save

i8 = Ingredient.find_or_create_by(name: "Lactose")
i8.como_rating = nil
i8.save

pi8 = ProductIngredient.create
pi8.product_id = p2.id
pi8.ingredient_id = i8.id
pi8.save

i9 = Ingredient.find_or_create_by(name: "Milk Protein")
i9.como_rating = nil
i9.save

pi9 = ProductIngredient.create
pi9.product_id = p2.id
pi9.ingredient_id = i9.id
pi9.save

i10 = Ingredient.find_or_create_by(name: "Bifida Ferment Lysate")
i10.como_rating = nil
i10.save

pi10 = ProductIngredient.create
pi10.product_id = p2.id
pi10.ingredient_id = i10.id
pi10.save

i11 = Ingredient.find_or_create_by(name: "Yogurt Extract")
i11.como_rating = nil
i11.save

pi11 = ProductIngredient.create
pi11.product_id = p2.id
pi11.ingredient_id = i11.id
pi11.save

i12 = Ingredient.find_or_create_by(name: "Hydrolyzed Rice Protein")
i12.como_rating = nil
i12.save

pi12 = ProductIngredient.create
pi12.product_id = p2.id
pi12.ingredient_id = i12.id
pi12.save

i13 = Ingredient.find_or_create_by(name: "Cichorium Intybus Root Extract")
i13.como_rating = nil
i13.save

pi13 = ProductIngredient.create
pi13.product_id = p2.id
pi13.ingredient_id = i13.id
pi13.save

i14 = Ingredient.find_or_create_by(name: "Vaccinium Angustifolium Fruit Extract")
i14.como_rating = nil
i14.save

pi14 = ProductIngredient.create
pi14.product_id = p2.id
pi14.ingredient_id = i14.id
pi14.save

i15 = Ingredient.find_or_create_by(name: "Vegetable Oil")
i15.como_rating = nil
i15.save

pi15 = ProductIngredient.create
pi15.product_id = p2.id
pi15.ingredient_id = i15.id
pi15.save

i16 = Ingredient.find_or_create_by(name: "Camelina Sativa Seed Oil")
i16.como_rating = nil
i16.save

pi16 = ProductIngredient.create
pi16.product_id = p2.id
pi16.ingredient_id = i16.id
pi16.save

i17 = Ingredient.find_or_create_by(name: "Camellia Sinensis Leaf Extract")
i17.como_rating = nil
i17.save

pi17 = ProductIngredient.create
pi17.product_id = p2.id
pi17.ingredient_id = i17.id
pi17.save

i18 = Ingredient.find_or_create_by(name: "Curcuma Longa Root Extract")
i18.como_rating = nil
i18.save

pi18 = ProductIngredient.create
pi18.product_id = p2.id
pi18.ingredient_id = i18.id
pi18.save

i19 = Ingredient.find_or_create_by(name: "Tocopheryl Acetate")
i19.como_rating = 0
i19.save

pi19 = ProductIngredient.create
pi19.product_id = p2.id
pi19.ingredient_id = i19.id
pi19.save

i20 = Ingredient.find_or_create_by(name: "Retinyl Palmitate")
i20.como_rating = 2
i20.save

pi20 = ProductIngredient.create
pi20.product_id = p2.id
pi20.ingredient_id = i20.id
pi20.save

i21 = Ingredient.find_or_create_by(name: "Ascorbyl Palmitate")
i21.como_rating = 2
i21.save

pi21 = ProductIngredient.create
pi21.product_id = p2.id
pi21.ingredient_id = i21.id
pi21.save

i22 = Ingredient.find_or_create_by(name: "Panthenol")
i22.como_rating = 0
i22.save

pi22 = ProductIngredient.create
pi22.product_id = p2.id
pi22.ingredient_id = i22.id
pi22.save

i23 = Ingredient.find_or_create_by(name: "Carthamus Tinctorius Seed Oil")
i23.como_rating = 0
i23.save

pi23 = ProductIngredient.create
pi23.product_id = p2.id
pi23.ingredient_id = i23.id
pi23.save

i24 = Ingredient.find_or_create_by(name: "Polyquaternium-10")
i24.como_rating = nil
i24.save

pi24 = ProductIngredient.create
pi24.product_id = p2.id
pi24.ingredient_id = i24.id
pi24.save

i25 = Ingredient.find_or_create_by(name: "Butylene Glycol")
i25.como_rating = 1
i25.save

pi25 = ProductIngredient.create
pi25.product_id = p2.id
pi25.ingredient_id = i25.id
pi25.save

i26 = Ingredient.find_or_create_by(name: "Sodium Chloride")
i26.como_rating = nil
i26.save

pi26 = ProductIngredient.create
pi26.product_id = p2.id
pi26.ingredient_id = i26.id
pi26.save

i27 = Ingredient.find_or_create_by(name: "Pentylene Glycol")
i27.como_rating = nil
i27.save

pi27 = ProductIngredient.create
pi27.product_id = p2.id
pi27.ingredient_id = i27.id
pi27.save

i28 = Ingredient.find_or_create_by(name: "Caprylyl Glycol")
i28.como_rating = nil
i28.save

pi28 = ProductIngredient.create
pi28.product_id = p2.id
pi28.ingredient_id = i28.id
pi28.save

i29 = Ingredient.find_or_create_by(name: "Ethylhexylglycerin")
i29.como_rating = nil
i29.save

pi29 = ProductIngredient.create
pi29.product_id = p2.id
pi29.ingredient_id = i29.id
pi29.save

i30 = Ingredient.find_or_create_by(name: "Bulnesia Sarmientoi Wood Oil")
i30.como_rating = nil
i30.save

pi30 = ProductIngredient.create
pi30.product_id = p2.id
pi30.ingredient_id = i30.id
pi30.save

i31 = Ingredient.find_or_create_by(name: "Citrus Limon Fruit Oil")
i31.como_rating = nil
i31.save

pi31 = ProductIngredient.create
pi31.product_id = p2.id
pi31.ingredient_id = i31.id
pi31.save

i32 = Ingredient.find_or_create_by(name: "Citrus Aurantium Dulcis (Orange) Oil")
i32.como_rating = nil
i32.save

pi32 = ProductIngredient.create
pi32.product_id = p2.id
pi32.ingredient_id = i32.id
pi32.save

i33 = Ingredient.find_or_create_by(name: "Juniperus Mexicana Oil")
i33.como_rating = nil
i33.save

pi33 = ProductIngredient.create
pi33.product_id = p2.id
pi33.ingredient_id = i33.id
pi33.save

i34 = Ingredient.find_or_create_by(name: "Cananga Odorata Flower Oil")
i34.como_rating = nil
i34.save

pi34 = ProductIngredient.create
pi34.product_id = p2.id
pi34.ingredient_id = i34.id
pi34.save

i35 = Ingredient.find_or_create_by(name: "Fragrance")
i35.como_rating = nil
i35.save

pi35 = ProductIngredient.create
pi35.product_id = p2.id
pi35.ingredient_id = i35.id
pi35.save

i36 = Ingredient.find_or_create_by(name: "Sorbic Acid")
i36.como_rating = nil
i36.save

pi36 = ProductIngredient.create
pi36.product_id = p2.id
pi36.ingredient_id = i36.id
pi36.save

i37 = Ingredient.find_or_create_by(name: "Phenoxyethanol")
i37.como_rating = nil
i37.save

pi37 = ProductIngredient.create
pi37.product_id = p2.id
pi37.ingredient_id = i37.id
pi37.save

i38 = Ingredient.find_or_create_by(name: "Disodium EDTA")
i38.como_rating = nil
i38.save

pi38 = ProductIngredient.create
pi38.product_id = p2.id
pi38.ingredient_id = i38.id
pi38.save

i39 = Ingredient.find_or_create_by(name: "Methylchloroisothiazolinone")
i39.como_rating = nil
i39.save

pi39 = ProductIngredient.create
pi39.product_id = p2.id
pi39.ingredient_id = i39.id
pi39.save

i40 = Ingredient.find_or_create_by(name: "Methylisothiazolinone")
i40.como_rating = nil
i40.save

pi40 = ProductIngredient.create
pi40.product_id = p2.id
pi40.ingredient_id = i40.id
pi40.save

###################

p3 = Product.create
p3.brand = "Cetaphil"
p3.name = "Gentle Skin Cleanser"
p3.category = "cleanser"
p3.img_url = "https://s3-ap-southeast-1.amazonaws.com/skincarisma-staging/submitted_images/files/000/013/389/medium/cetaphil-gentle-skin-cleanser.jpg?1521899667"
p3.sunscreen_type = nil
p3.spf = nil
p3.pa = nil
p3.save

up3 = UserProduct.create
up3.user_id = 13
up3.product_id = p3.id
up3.current = false
up3.rating = 1
up3.wishlist = false
up3.opened = nil
up3.expires = nil
up3.caused_acne = true
up3.notes = "Caused cystic acne breakout."
up3.save

i1 = Ingredient.find_or_create_by(name: "Water")
i1.como_rating = nil
i1.save

pi1 = ProductIngredient.create
pi1.product_id = p3.id
pi1.ingredient_id = i1.id
pi1.save

i2 = Ingredient.find_or_create_by(name: "Cetyl Alcohol")
i2.como_rating = 2
i2.save

pi2 = ProductIngredient.create
pi2.product_id = p3.id
pi2.ingredient_id = i2.id
pi2.save

i3 = Ingredient.find_or_create_by(name: "Propylene Glycol")
i3.como_rating = nil
i3.save

pi3 = ProductIngredient.create
pi3.product_id = p3.id
pi3.ingredient_id = i3.id
pi3.save

i4 = Ingredient.find_or_create_by(name: "Sodium Lauryl Sulfate")
i4.como_rating = nil
i4.save

pi4 = ProductIngredient.create
pi4.product_id = p3.id
pi4.ingredient_id = i4.id
pi4.save

i5 = Ingredient.find_or_create_by(name: "Stearyl Alcohol")
i5.como_rating = 2
i5.save

pi5 = ProductIngredient.create
pi5.product_id = p3.id
pi5.ingredient_id = i5.id
pi5.save

i6 = Ingredient.find_or_create_by(name: "Methylparaben")
i6.como_rating = nil
i6.save

pi6 = ProductIngredient.create
pi6.product_id = p3.id
pi6.ingredient_id = i6.id
pi6.save

i7 = Ingredient.find_or_create_by(name: "Propylparaben")
i7.como_rating = 0
i7.save

pi7 = ProductIngredient.create
pi7.product_id = p3.id
pi7.ingredient_id = i7.id
pi7.save

i8 = Ingredient.find_or_create_by(name: "Butylparaben")
i8.como_rating = nil
i8.save

pi8 = ProductIngredient.create
pi8.product_id = p3.id
pi8.ingredient_id = i8.id
pi8.save

###################

p4 = Product.create
p4.brand = "Hada Labo"
p4.name = "Gokujyun Perfect Gel"
p4.category = "Moisturizer"
p4.img_url = "https://cdn.shopify.com/s/files/1/1795/7013/products/4_3bff5922-c769-4be8-a8db-39ab1c4ad837_1200x.png?v=1522270844"
p4.sunscreen_type = nil
p4.spf = nil
p4.pa = nil
p4.save

up4 = UserProduct.create
up4.user_id = 13
up4.product_id = p4.id
up4.current = true
up4.rating = 5
up4.wishlist = false
up4.opened = nil
up4.expires = nil
up4.caused_acne = false
up4.notes = "Holy Grail Moisturizer!"
up4.save

i1 = Ingredient.find_or_create_by(name: "Water")
i1.como_rating = nil
i1.save

pi1 = ProductIngredient.create
pi1.product_id = p4.id
pi1.ingredient_id = i1.id
pi1.save

i2 = Ingredient.find_or_create_by(name: "Butylene Glycol")
i2.como_rating = 1
i2.save

pi2 = ProductIngredient.create
pi2.product_id = p4.id
pi2.ingredient_id = i2.id
pi2.save

i3 = Ingredient.find_or_create_by(name: "Hydroxyethyl Urea")
i3.como_rating = nil
i3.save

pi3 = ProductIngredient.create
pi3.product_id = p4.id
pi3.ingredient_id = i3.id
pi3.save

i4 = Ingredient.find_or_create_by(name: "Pentylene Glycol")
i4.como_rating = nil
i4.save

pi4 = ProductIngredient.create
pi4.product_id = p4.id
pi4.ingredient_id = i4.id
pi4.save

i5 = Ingredient.find_or_create_by(name: "Glycerin")
i5.como_rating = 0
i5.save

pi5 = ProductIngredient.create
pi5.product_id = p4.id
pi5.ingredient_id = i5.id
pi5.save

i6 = Ingredient.find_or_create_by(name: "Squalane")
i6.como_rating = 1
i6.save

pi6 = ProductIngredient.create
pi6.product_id = p4.id
pi6.ingredient_id = i6.id
pi6.save

i7 = Ingredient.find_or_create_by(name: "PEG/PPG/Polybutylene Glycol-8/5/3 Glycerin")
i7.como_rating = nil
i7.save

pi7 = ProductIngredient.create
pi7.product_id = p4.id
pi7.ingredient_id = i7.id
pi7.save

i8 = Ingredient.find_or_create_by(name: "Triethylhexanoin")
i8.como_rating = nil
i8.save

pi8 = ProductIngredient.create
pi8.product_id = p4.id
pi8.ingredient_id = i8.id
pi8.save

i9 = Ingredient.find_or_create_by(name: "Ammonium Acryloyldimethyltaurate/VP Copolymer")
i9.como_rating = nil
i9.save

pi9 = ProductIngredient.create
pi9.product_id = p4.id
pi9.ingredient_id = i9.id
pi9.save

i10 = Ingredient.find_or_create_by(name: "Agar")
i10.como_rating = nil
i10.save

pi10 = ProductIngredient.create
pi10.product_id = p4.id
pi10.ingredient_id = i10.id
pi10.save

i11 = Ingredient.find_or_create_by(name: "Arginine")
i11.como_rating = nil
i11.save

pi11 = ProductIngredient.create
pi11.product_id = p4.id
pi11.ingredient_id = i11.id
pi11.save

i12 = Ingredient.find_or_create_by(name: "Dextrin")
i12.como_rating = nil
i12.save

pi12 = ProductIngredient.create
pi12.product_id = p4.id
pi12.ingredient_id = i12.id
pi12.save

i13 = Ingredient.find_or_create_by(name: "Dimethicone")
i13.como_rating = 1
i13.save

pi13 = ProductIngredient.create
pi13.product_id = p4.id
pi13.ingredient_id = i13.id
pi13.save

i14 = Ingredient.find_or_create_by(name: "Disodium EDTA")
i14.como_rating = nil
i14.save

pi14 = ProductIngredient.create
pi14.product_id = p4.id
pi14.ingredient_id = i14.id
pi14.save

i15 = Ingredient.find_or_create_by(name: "Disodium Succinate")
i15.como_rating = nil
i15.save

pi15 = ProductIngredient.create
pi15.product_id = p4.id
pi15.ingredient_id = i15.id
pi15.save

i16 = Ingredient.find_or_create_by(name: "Glucosyl Ceramide")
i16.como_rating = nil
i16.save

pi16 = ProductIngredient.create
pi16.product_id = p4.id
pi16.ingredient_id = i16.id
pi16.save

i17 = Ingredient.find_or_create_by(name: "Hydrolyzed Collagen")
i17.como_rating = 0
i17.save

pi17 = ProductIngredient.create
pi17.product_id = p4.id
pi17.ingredient_id = i17.id
pi17.save

i18 = Ingredient.find_or_create_by(name: "Hydrolyzed Hyaluronic Acid")
i18.como_rating = nil
i18.save

pi18 = ProductIngredient.create
pi18.product_id = p4.id
pi18.ingredient_id = i18.id
pi18.save

i19 = Ingredient.find_or_create_by(name: "Methylparaben")
i19.como_rating = 0
i19.save

pi19 = ProductIngredient.create
pi19.product_id = p4.id
pi19.ingredient_id = i19.id
pi19.save

i20 = Ingredient.find_or_create_by(name: "Phenoxyethanol")
i20.como_rating = nil
i20.save

pi20 = ProductIngredient.create
pi20.product_id = p4.id
pi20.ingredient_id = i20.id
pi20.save

i21 = Ingredient.find_or_create_by(name: "Propylparaben")
i21.como_rating = 0
i21.save

pi21 = ProductIngredient.create
pi21.product_id = p4.id
pi21.ingredient_id = i21.id
pi21.save

i22 = Ingredient.find_or_create_by(name: "Sodium Acetylated Hyaluronate")
i22.como_rating = nil
i22.save

pi22 = ProductIngredient.create
pi22.product_id = p4.id
pi22.ingredient_id = i22.id
pi22.save

i23 = Ingredient.find_or_create_by(name: "Sodium Hyaluronate")
i23.como_rating = 0
i23.save

pi23 = ProductIngredient.create
pi23.product_id = p4.id
pi23.ingredient_id = i23.id
pi23.save

i24 = Ingredient.find_or_create_by(name: "Succinic Acid")
i24.como_rating = nil
i24.save

pi24 = ProductIngredient.create
pi24.product_id = p4.id
pi24.ingredient_id = i24.id
pi24.save

i25 = Ingredient.find_or_create_by(name: "Triethyl Citrate")
i25.como_rating = nil
i25.save

pi25 = ProductIngredient.create
pi25.product_id = p4.id
pi25.ingredient_id = i25.id
pi25.save

###################

p5 = Product.create
p5.brand = "Stridex"
p5.name = "Maximum"
p5.category = "Active"
p5.img_url = "https://pics.drugstore.com/prodimg/151226/900.jpg"
p5.sunscreen_type = nil
p5.spf = nil
p5.pa = nil
p5.save

up5 = UserProduct.create
up5.user_id = 13
up5.product_id = p5.id
up5.current = false
up5.rating = 4 
up5.wishlist = false
up5.opened = nil
up5.expires = nil
up5.caused_acne = false
up5.notes = "Drying but effective."
up5.save

i1 = Ingredient.find_or_create_by(name: "Salicylic Acid, 2%")
i1.como_rating = nil
i1.save

pi1 = ProductIngredient.create
pi1.product_id = p5.id
pi1.ingredient_id = i1.id
pi1.save

i2 = Ingredient.find_or_create_by(name: "Aminomethyl Propanol")
i2.como_rating = nil
i2.save

pi2 = ProductIngredient.create
pi2.product_id = p5.id
pi2.ingredient_id = i2.id
pi2.save

i3 = Ingredient.find_or_create_by(name: "Ammonium Xylenesulfonate")
i3.como_rating = nil
i3.save

pi3 = ProductIngredient.create
pi3.product_id = p5.id
pi3.ingredient_id = i3.id
pi3.save

i4 = Ingredient.find_or_create_by(name: "Citric Acid")
i4.como_rating = nil
i4.save

pi4 = ProductIngredient.create
pi4.product_id = p5.id
pi4.ingredient_id = i4.id
pi4.save

i5 = Ingredient.find_or_create_by(name: "DMDM Hydantoin")
i5.como_rating = nil
i5.save

pi5 = ProductIngredient.create
pi5.product_id = p5.id
pi5.ingredient_id = i5.id
pi5.save

i6 = Ingredient.find_or_create_by(name: "Fragrance")
i6.como_rating = nil
i6.save

pi6 = ProductIngredient.create
pi6.product_id = p5.id
pi6.ingredient_id = i6.id
pi6.save

i7 = Ingredient.find_or_create_by(name: "Menthol")
i7.como_rating = nil
i7.save

pi7 = ProductIngredient.create
pi7.product_id = p5.id
pi7.ingredient_id = i7.id
pi7.save

i8 = Ingredient.find_or_create_by(name: "PPG-5-Ceteth-20")
i8.como_rating = nil
i8.save

pi8 = ProductIngredient.create
pi8.product_id = p5.id
pi8.ingredient_id = i8.id
pi8.save

i9 = Ingredient.find_or_create_by(name: "Water")
i9.como_rating = nil
i9.save

pi9 = ProductIngredient.create
pi9.product_id = p5.id
pi9.ingredient_id = i9.id
pi9.save

i10 = Ingredient.find_or_create_by(name: "Simethicone")
i10.como_rating = 1
i10.save

pi10 = ProductIngredient.create
pi10.product_id = p5.id
pi10.ingredient_id = i10.id
pi10.save

i11 = Ingredient.find_or_create_by(name: "Sodium Borate")
i11.como_rating = nil
i11.save

pi11 = ProductIngredient.create
pi11.product_id = p5.id
pi11.ingredient_id = i11.id
pi11.save

i12 = Ingredient.find_or_create_by(name: "Tetrasodium EDTA")
i12.como_rating = nil
i12.save

pi12 = ProductIngredient.create
pi12.product_id = p5.id
pi12.ingredient_id = i12.id
pi12.save

###################

p6 = Product.create
p6.brand = "Canmake"
p6.name = "Mermaid Skin Gel UV SPF50+ PA++++"
p6.category = "sunscreen"
p6.img_url = "https://s3-ap-southeast-1.amazonaws.com/skincarisma-staging/submitted_images/files/000/049/306/medium/mermaid-skin-gel-uv-spf50-pa.jpg?1549908900"
p6.sunscreen_type = "chemical"
p6.spf = "50"
p6.pa = "++++"
p6.save

up6 = UserProduct.create
up6.user_id = 13
up6.product_id = p6.id
up6.current = false
up6.rating = 4
up6.wishlist = false
up6.opened = nil
up6.expires = nil
up6.caused_acne = true
up6.notes = "Perfect consistency, but caused acne."
up6.save

i1 = Ingredient.find_or_create_by(name: "Water")
i1.como_rating = nil
i1.save

pi1 = ProductIngredient.create
pi1.product_id = p6.id
pi1.ingredient_id = i1.id
pi1.save

i2 = Ingredient.find_or_create_by(name: "Ethylhexyl Methoxycinnamate")
i2.como_rating = 0
i2.save

pi2 = ProductIngredient.create
pi2.product_id = p6.id
pi2.ingredient_id = i2.id
pi2.save

i3 = Ingredient.find_or_create_by(name: "Butylene Glycol")
i3.como_rating = 1
i3.save

pi3 = ProductIngredient.create
pi3.product_id = p6.id
pi3.ingredient_id = i3.id
pi3.save

i4 = Ingredient.find_or_create_by(name: "Diethylamino Hydroxybenzoyl Hexyl Benzoate")
i4.como_rating = nil
i4.save

pi4 = ProductIngredient.create
pi4.product_id = p6.id
pi4.ingredient_id = i4.id
pi4.save

i5 = Ingredient.find_or_create_by(name: "Zinc Oxide")
i5.como_rating = 1
i5.save

pi5 = ProductIngredient.create
pi5.product_id = p6.id
pi5.ingredient_id = i5.id
pi5.save

i6 = Ingredient.find_or_create_by(name: "Methylheptyl Isostearate")
i6.como_rating = nil
i6.save

pi6 = ProductIngredient.create
pi6.product_id = p6.id
pi6.ingredient_id = i6.id
pi6.save

i7 = Ingredient.find_or_create_by(name: "Titanium Dioxide")
i7.como_rating = 0
i7.save

pi7 = ProductIngredient.create
pi7.product_id = p6.id
pi7.ingredient_id = i7.id
pi7.save

i8 = Ingredient.find_or_create_by(name: "Dimethicone")
i8.como_rating = 1
i8.save

pi8 = ProductIngredient.create
pi8.product_id = p6.id
pi8.ingredient_id = i8.id
pi8.save

i9 = Ingredient.find_or_create_by(name: "Bis-Ethylhexyloxyphenol Methoxyphenyl Triazine")
i9.como_rating = nil
i9.save

pi9 = ProductIngredient.create
pi9.product_id = p6.id
pi9.ingredient_id = i9.id
pi9.save

i10 = Ingredient.find_or_create_by(name: "Polymethylsilsesquioxane")
i10.como_rating = nil
i10.save

pi10 = ProductIngredient.create
pi10.product_id = p6.id
pi10.ingredient_id = i10.id
pi10.save

i11 = Ingredient.find_or_create_by(name: "Cyclopentasiloxane")
i11.como_rating = nil
i11.save

pi11 = ProductIngredient.create
pi11.product_id = p6.id
pi11.ingredient_id = i11.id
pi11.save

i12 = Ingredient.find_or_create_by(name: "Acryloyldimethyltaurate/VP Copolymer")
i12.como_rating = nil
i12.save

pi12 = ProductIngredient.create
pi12.product_id = p6.id
pi12.ingredient_id = i12.id
pi12.save

i13 = Ingredient.find_or_create_by(name: "Diisostearyl Malate")
i13.como_rating = nil
i13.save

pi13 = ProductIngredient.create
pi13.product_id = p6.id
pi13.ingredient_id = i13.id
pi13.save

i14 = Ingredient.find_or_create_by(name: "Aluminum Hydroxide")
i14.como_rating = nil
i14.save

pi14 = ProductIngredient.create
pi14.product_id = p6.id
pi14.ingredient_id = i14.id
pi14.save

i15 = Ingredient.find_or_create_by(name: "PEG-60 Hydrogenated Castor Oil")
i15.como_rating = nil
i15.save

pi15 = ProductIngredient.create
pi15.product_id = p6.id
pi15.ingredient_id = i15.id
pi15.save

i16 = Ingredient.find_or_create_by(name: "Stearic Acid")
i16.como_rating = 3
i16.save

pi16 = ProductIngredient.create
pi16.product_id = p6.id
pi16.ingredient_id = i16.id
pi16.save

i17 = Ingredient.find_or_create_by(name: "Phenoxyethanol")
i17.como_rating = nil
i17.save

pi17 = ProductIngredient.create
pi17.product_id = p6.id
pi17.ingredient_id = i17.id
pi17.save

i18 = Ingredient.find_or_create_by(name: "Polyglyceryl-3 Polydimethylsiloxyethyl Dimethicone")
i18.como_rating = nil
i18.save

pi18 = ProductIngredient.create
pi18.product_id = p6.id
pi18.ingredient_id = i18.id
pi18.save

i19 = Ingredient.find_or_create_by(name: "Polyhydroxystearic Acid")
i19.como_rating = nil
i19.save

pi19 = ProductIngredient.create
pi19.product_id = p6.id
pi19.ingredient_id = i19.id
pi19.save

i20 = Ingredient.find_or_create_by(name: "Jojoba Esters")
i20.como_rating = nil
i20.save

pi20 = ProductIngredient.create
pi20.product_id = p6.id
pi20.ingredient_id = i20.id
pi20.save

i21 = Ingredient.find_or_create_by(name: "Xanthan Gum")
i21.como_rating = nil
i21.save

pi21 = ProductIngredient.create
pi21.product_id = p6.id
pi21.ingredient_id = i21.id
pi21.save

i22 = Ingredient.find_or_create_by(name: "Arginine")
i22.como_rating = nil
i22.save

pi22 = ProductIngredient.create
pi22.product_id = p6.id
pi22.ingredient_id = i22.id
pi22.save

i23 = Ingredient.find_or_create_by(name: "Hyaluronic Acid")
i23.como_rating = nil
i23.save

pi23 = ProductIngredient.create
pi23.product_id = p6.id
pi23.ingredient_id = i23.id
pi23.save

i24 = Ingredient.find_or_create_by(name: "Alpha-Glucan")
i24.como_rating = nil
i24.save

pi24 = ProductIngredient.create
pi24.product_id = p6.id
pi24.ingredient_id = i24.id
pi24.save

i25 = Ingredient.find_or_create_by(name: "Phytic Acid")
i25.como_rating = nil
i25.save

pi25 = ProductIngredient.create
pi25.product_id = p6.id
pi25.ingredient_id = i25.id
pi25.save

i26 = Ingredient.find_or_create_by(name: "Saxifraga Sarmentosa Extract")
i26.como_rating = nil
i26.save

pi26 = ProductIngredient.create
pi26.product_id = p6.id
pi26.ingredient_id = i26.id
pi26.save

i27 = Ingredient.find_or_create_by(name: "Glucosyl Ceramide")
i27.como_rating = nil
i27.save

pi27 = ProductIngredient.create
pi27.product_id = p6.id
pi27.ingredient_id = i27.id
pi27.save

i28 = Ingredient.find_or_create_by(name: "Prunus Yedoensis Leaf Extract")
i28.como_rating = nil
i28.save

pi28 = ProductIngredient.create
pi28.product_id = p6.id
pi28.ingredient_id = i28.id
pi28.save

i29 = Ingredient.find_or_create_by(name: "Coix Lacryma-Jobi Ma-yuen (Job's Tears)")
i29.como_rating = nil
i29.save

pi29 = ProductIngredient.create
pi29.product_id = p6.id
pi29.ingredient_id = i29.id
pi29.save

i30 = Ingredient.find_or_create_by(name: "Morus Alba Root Extract")
i30.como_rating = nil
i30.save

pi30 = ProductIngredient.create
pi30.product_id = p6.id
pi30.ingredient_id = i30.id
pi30.save

i31 = Ingredient.find_or_create_by(name: "Oenothera Biennis (Evening Primrose) Seed Extract")
i31.como_rating = nil
i31.save

pi31 = ProductIngredient.create
pi31.product_id = p6.id
pi31.ingredient_id = i31.id
pi31.save

i32 = Ingredient.find_or_create_by(name: "Silver Oxide")
i32.como_rating = nil
i32.save

pi32 = ProductIngredient.create
pi32.product_id = p6.id
pi32.ingredient_id = i32.id
pi32.save

i33 = Ingredient.find_or_create_by(name: "Spiraea Ulmaria Flower Extract")
i33.como_rating = nil
i33.save

pi33 = ProductIngredient.create
pi33.product_id = p6.id
pi33.ingredient_id = i33.id
pi33.save

i34 = Ingredient.find_or_create_by(name: "Vaccinium Myrtillus (Bilberry) Extract")
i34.como_rating = nil
i34.save

pi34 = ProductIngredient.create
pi34.product_id = p6.id
pi34.ingredient_id = i34.id
pi34.save

i35 = Ingredient.find_or_create_by(name: "Cynara Scolymus (Artichoke) Leaf Extract")
i35.como_rating = nil
i35.save

pi35 = ProductIngredient.create
pi35.product_id = p6.id
pi35.ingredient_id = i35.id
pi35.save

###################

p7 = Product.create
p7.brand = "Banila Co."
p7.name = "Clean It Zero"
p7.category = "cleanser"
p7.img_url = "https://s3-ap-southeast-1.amazonaws.com/skincarisma-staging/submitted_images/files/000/050/083/medium/clean-it-zero-classic.jpg?1549911801"
p7.sunscreen_type = nil
p7.spf = nil
p7.pa = nil
p7.save

up7 = UserProduct.create
up7.user_id = 13
up7.product_id = p7.id
up7.current = false
up7.rating = 5
up7.wishlist = false
up7.opened = nil
up7.expires =  nil
up7.caused_acne = false
up7.notes = nil
up7.save

i1 = Ingredient.find_or_create_by(name: "Mineral Oil")
i1.como_rating = 2
i1.save

pi1 = ProductIngredient.create
pi1.product_id = p7.id
pi1.ingredient_id = i1.id
pi1.save

i2 = Ingredient.find_or_create_by(name: "Cetyl Ethylhexanoate")
i2.como_rating = nil
i2.save

pi2 = ProductIngredient.create
pi2.product_id = p7.id
pi2.ingredient_id = i2.id
pi2.save

i3 = Ingredient.find_or_create_by(name: "PEG-20 Glyceryl Triisostearate")
i3.como_rating = nil
i3.save

pi3 = ProductIngredient.create
pi3.product_id = p7.id
pi3.ingredient_id = i3.id
pi3.save

i4 = Ingredient.find_or_create_by(name: "PEG-10 Isostearate")
i4.como_rating = nil
i4.save

pi4 = ProductIngredient.create
pi4.product_id = p7.id
pi4.ingredient_id = i4.id
pi4.save

i5 = Ingredient.find_or_create_by(name: "Polyethylene")
i5.como_rating = nil
i5.save

pi5 = ProductIngredient.create
pi5.product_id = p7.id
pi5.ingredient_id = i5.id
pi5.save

i6 = Ingredient.find_or_create_by(name: "Butylene Glycol")
i6.como_rating = 1
i6.save

pi6 = ProductIngredient.create
pi6.product_id = p7.id
pi6.ingredient_id = i6.id
pi6.save

i7 = Ingredient.find_or_create_by(name: "Water")
i7.como_rating = nil
i7.save

pi7 = ProductIngredient.create
pi7.product_id = p7.id
pi7.ingredient_id = i7.id
pi7.save

i8 = Ingredient.find_or_create_by(name: "Rubus Suavissimus (Raspberry) Leaf Extract")
i8.como_rating = nil
i8.save

pi8 = ProductIngredient.create
pi8.product_id = p7.id
pi8.ingredient_id = i8.id
pi8.save

i9 = Ingredient.find_or_create_by(name: "Bambusa Arundinacea Stem Extract")
i9.como_rating = nil
i9.save

pi9 = ProductIngredient.create
pi9.product_id = p7.id
pi9.ingredient_id = i9.id
pi9.save

i10 = Ingredient.find_or_create_by(name: "Aspalathus Linearis Leaf Extract")
i10.como_rating = nil
i10.save

pi10 = ProductIngredient.create
pi10.product_id = p7.id
pi10.ingredient_id = i10.id
pi10.save

i11 = Ingredient.find_or_create_by(name: "Viscum Album (Mistletoe) Leaf Extract")
i11.como_rating = nil
i11.save

pi11 = ProductIngredient.create
pi11.product_id = p7.id
pi11.ingredient_id = i11.id
pi11.save

i12 = Ingredient.find_or_create_by(name: "Angelica Polymorpha Sinensis Root Extract")
i12.como_rating = nil
i12.save

pi12 = ProductIngredient.create
pi12.product_id = p7.id
pi12.ingredient_id = i12.id
pi12.save

i13 = Ingredient.find_or_create_by(name: "Carica Papaya (Papaya) Fruit Extract")
i13.como_rating = nil
i13.save

pi13 = ProductIngredient.create
pi13.product_id = p7.id
pi13.ingredient_id = i13.id
pi13.save

i14 = Ingredient.find_or_create_by(name: "Malpighia Glabra (Acerola) Fruit Extract")
i14.como_rating = nil
i14.save

pi14 = ProductIngredient.create
pi14.product_id = p7.id
pi14.ingredient_id = i14.id
pi14.save

i15 = Ingredient.find_or_create_by(name: "Epilobium Angustifolium Leaf Extract")
i15.como_rating = nil
i15.save

pi15 = ProductIngredient.create
pi15.product_id = p7.id
pi15.ingredient_id = i15.id
pi15.save

i16 = Ingredient.find_or_create_by(name: "BHT")
i16.como_rating = nil
i16.save

pi16 = ProductIngredient.create
pi16.product_id = p7.id
pi16.ingredient_id = i16.id
pi16.save

i17 = Ingredient.find_or_create_by(name: "Butylparaben")
i17.como_rating = nil
i17.save

pi17 = ProductIngredient.create
pi17.product_id = p7.id
pi17.ingredient_id = i17.id
pi17.save

i18 = Ingredient.find_or_create_by(name: "CI 16255")
i18.como_rating = nil
i18.save

pi18 = ProductIngredient.create
pi18.product_id = p7.id
pi18.ingredient_id = i18.id
pi18.save

i19 = Ingredient.find_or_create_by(name: "CI 15985")
i19.como_rating = nil
i19.save

pi19 = ProductIngredient.create
pi19.product_id = p7.id
pi19.ingredient_id = i19.id
pi19.save

i20 = Ingredient.find_or_create_by(name: "Fragrance")
i20.como_rating = nil
i20.save

pi20 = ProductIngredient.create
pi20.product_id = p7.id
pi20.ingredient_id = i20.id
pi20.save

###################

p8 = Product.create
p8.brand = "Blue Lizard"
p8.name = "Face"
p8.category = "Sunscreen"
p8.img_url = "https://i5.walmartimages.com/asr/a5cece97-f266-49c9-9fdf-d0aec3b51895_1.462e41e61a5ce3f49bc44f9c57321269.jpeg?odnWidth=450&odnHeight=450&odnBg=ffffff"
p8.sunscreen_type = "chemical"
p8.spf = "30+"
p8.pa = nil
p8.save

i1 = Ingredient.find_or_create_by(name: "Cinoxate")
i1.como_rating = nil
i1.save

pi1 = ProductIngredient.create
pi1.product_id = p8.id
pi1.ingredient_id = i1.id
pi1.save

i2 = Ingredient.find_or_create_by(name: "Zinc Oxide")
i2.como_rating = 1
i2.save

pi2 = ProductIngredient.create
pi2.product_id = p8.id
pi2.ingredient_id = i2.id
pi2.save

i3 = Ingredient.find_or_create_by(name: "Water")
i3.como_rating = nil
i3.save

pi3 = ProductIngredient.create
pi3.product_id = p8.id
pi3.ingredient_id = i3.id
pi3.save

i4 = Ingredient.find_or_create_by(name: "C12-15 Alkyl Benzoate")
i4.como_rating = nil
i4.save

pi4 = ProductIngredient.create
pi4.product_id = p8.id
pi4.ingredient_id = i4.id
pi4.save

i5 = Ingredient.find_or_create_by(name: "Cyclomethicone")
i5.como_rating = 1
i5.save

pi5 = ProductIngredient.create
pi5.product_id = p8.id
pi5.ingredient_id = i5.id
pi5.save

i6 = Ingredient.find_or_create_by(name: "Lauryl PEG/PPG-18/18 Methicone")
i6.como_rating = nil
i6.save

pi6 = ProductIngredient.create
pi6.product_id = p8.id
pi6.ingredient_id = i6.id
pi6.save

i7 = Ingredient.find_or_create_by(name: "Polyacrylamide")
i7.como_rating = nil
i7.save

pi7 = ProductIngredient.create
pi7.product_id = p8.id
pi7.ingredient_id = i7.id
pi7.save

i8 = Ingredient.find_or_create_by(name: "C13-14 Isoparaffin")
i8.como_rating = nil
i8.save

pi8 = ProductIngredient.create
pi8.product_id = p8.id
pi8.ingredient_id = i8.id
pi8.save

i9 = Ingredient.find_or_create_by(name: "Laureth-7")
i9.como_rating = nil
i9.save

pi9 = ProductIngredient.create
pi9.product_id = p8.id
pi9.ingredient_id = i9.id
pi9.save

i10 = Ingredient.find_or_create_by(name: "Tocopheryl Acetate (Vitamin E)")
i10.como_rating = 0
i10.save

pi10 = ProductIngredient.create
pi10.product_id = p8.id
pi10.ingredient_id = i10.id
pi10.save

i11 = Ingredient.find_or_create_by(name: "Hyaluronic Acid")
i11.como_rating = nil
i11.save

pi11 = ProductIngredient.create
pi11.product_id = p8.id
pi11.ingredient_id = i11.id
pi11.save

i12 = Ingredient.find_or_create_by(name: "Camellia Sinensis (Green Tea) Leaf Extract")
i12.como_rating = nil
i12.save

pi12 = ProductIngredient.create
pi12.product_id = p8.id
pi12.ingredient_id = i12.id
pi12.save

i13 = Ingredient.find_or_create_by(name: "PEG-8 Beeswax")
i13.como_rating = nil
i13.save

pi13 = ProductIngredient.create
pi13.product_id = p8.id
pi13.ingredient_id = i13.id
pi13.save

i14 = Ingredient.find_or_create_by(name: "Caffeine")
i14.como_rating = nil
i14.save

pi14 = ProductIngredient.create
pi14.product_id = p8.id
pi14.ingredient_id = i14.id
pi14.save

i15 = Ingredient.find_or_create_by(name: "Diazolidinyl Urea")
i15.como_rating = nil
i15.save

pi15 = ProductIngredient.create
pi15.product_id = p8.id
pi15.ingredient_id = i15.id
pi15.save

i16 = Ingredient.find_or_create_by(name: "Methylparaben")
i16.como_rating = 0
i16.save

pi16 = ProductIngredient.create
pi16.product_id = p8.id
pi16.ingredient_id = i16.id
pi16.save

i17 = Ingredient.find_or_create_by(name: "Propylparaben")
i17.como_rating = nil
i17.save

pi17 = ProductIngredient.create
pi17.product_id = p8.id
pi17.ingredient_id = i17.id
pi17.save

###################

p9 = Product.create
p9.brand = "COSRX"
p9.name = "Ultimate Moisturizing Honey Overnight Mask"
p9.category = "mask"
p9.img_url = "https://cdn10.bigcommerce.com/s-6dbw5r/products/361/images/1647/1a8ebcccf3c6dbfda81a23bd599e3839__92388.1537308871.400.400.jpg?c=2"
p9.sunscreen_type = nil
p9.spf = nil
p9.pa = nil
p9.save

i1 = Ingredient.find_or_create_by(name: "Propolis Extract")
i1.como_rating = nil
i1.save

pi1 = ProductIngredient.create
pi1.product_id = p9.id
pi1.ingredient_id = i1.id
pi1.save

i2 = Ingredient.find_or_create_by(name: "Butylene Glycol")
i2.como_rating = 1
i2.save

pi2 = ProductIngredient.create
pi2.product_id = p9.id
pi2.ingredient_id = i2.id
pi2.save

i3 = Ingredient.find_or_create_by(name: "Glycerin")
i3.como_rating = nil
i3.save

pi3 = ProductIngredient.create
pi3.product_id = p9.id
pi3.ingredient_id = i3.id
pi3.save

i4 = Ingredient.find_or_create_by(name: "Betaine")
i4.como_rating = nil
i4.save

pi4 = ProductIngredient.create
pi4.product_id = p9.id
pi4.ingredient_id = i4.id
pi4.save

i5 = Ingredient.find_or_create_by(name: "1,2-Hexanediol")
i5.como_rating = nil
i5.save

pi5 = ProductIngredient.create
pi5.product_id = p9.id
pi5.ingredient_id = i5.id
pi5.save

i6 = Ingredient.find_or_create_by(name: "PEG-60 Hydrogenated Castor Oil")
i6.como_rating = nil
i6.save

pi6 = ProductIngredient.create
pi6.product_id = p9.id
pi6.ingredient_id = i6.id
pi6.save

i7 = Ingredient.find_or_create_by(name: "Arginine")
i7.como_rating = nil
i7.save

pi7 = ProductIngredient.create
pi7.product_id = p9.id
pi7.ingredient_id = i7.id
pi7.save

i8 = Ingredient.find_or_create_by(name: "Cassia Obtusifolia Seed Extract")
i8.como_rating = nil
i8.save

pi8 = ProductIngredient.create
pi8.product_id = p9.id
pi8.ingredient_id = i8.id
pi8.save

i9 = Ingredient.find_or_create_by(name: "Dimethicone")
i9.como_rating = 1
i9.save

pi9 = ProductIngredient.create
pi9.product_id = p9.id
pi9.ingredient_id = i9.id
pi9.save

i10 = Ingredient.find_or_create_by(name: "Ethylhexylglycerin")
i10.como_rating = nil
i10.save

pi10 = ProductIngredient.create
pi10.product_id = p9.id
pi10.ingredient_id = i10.id
pi10.save

i11 = Ingredient.find_or_create_by(name: "Carbomer")
i11.como_rating = nil
i11.save

pi11 = ProductIngredient.create
pi11.product_id = p9.id
pi11.ingredient_id = i11.id
pi11.save

i12 = Ingredient.find_or_create_by(name: "Sodium Hyaluronate")
i12.como_rating = nil
i12.save

pi12 = ProductIngredient.create
pi12.product_id = p9.id
pi12.ingredient_id = i12.id
pi12.save

i13 = Ingredient.find_or_create_by(name: "PEG-8 Beeswax")
i13.como_rating = nil
i13.save

pi13 = ProductIngredient.create
pi13.product_id = p9.id
pi13.ingredient_id = i13.id
pi13.save

i14 = Ingredient.find_or_create_by(name: "Allantoin")
i14.como_rating = nil
i14.save

pi14 = ProductIngredient.create
pi14.product_id = p9.id
pi14.ingredient_id = i14.id
pi14.save

i15 = Ingredient.find_or_create_by(name: "Panthenol")
i15.como_rating = nil
i15.save

pi15 = ProductIngredient.create
pi15.product_id = p9.id
pi15.ingredient_id = i15.id
pi15.save

i16 = Ingredient.find_or_create_by(name: "Sodium Polyacrylate")
i16.como_rating = nil
i16.save

pi16 = ProductIngredient.create
pi16.product_id = p9.id
pi16.ingredient_id = i16.id
pi16.save

i17 = Ingredient.find_or_create_by(name: "Adenosine")
i17.como_rating = nil
i17.save

pi17 = ProductIngredient.create
pi17.product_id = p9.id
pi17.ingredient_id = i17.id
pi17.save

###################

p10 = Product.create
p10.brand = "Queen Helene"
p10.name = "Mint Julep Masque"
p10.category = "XYZ"
p10.img_url = "https://images-na.ssl-images-amazon.com/images/I/71RDIOVPNbL._SL1500_.jpg"
p10.sunscreen_type = nil
p10.spf = nil
p10.pa = nil
p10.save

i1 = Ingredient.find_or_create_by(name: "Water")
i1.como_rating = nil
i1.save

pi1 = ProductIngredient.create
pi1.product_id = p10.id
pi1.ingredient_id = i1.id
pi1.save

i2 = Ingredient.find_or_create_by(name: "Kaolin")
i2.como_rating = 0
i2.save

pi2 = ProductIngredient.create
pi2.product_id = p10.id
pi2.ingredient_id = i2.id
pi2.save

i3 = Ingredient.find_or_create_by(name: "Bentonite")
i3.como_rating = 0
i3.save

pi3 = ProductIngredient.create
pi3.product_id = p10.id
pi3.ingredient_id = i3.id
pi3.save

i4 = Ingredient.find_or_create_by(name: "Glycerin")
i4.como_rating = 0
i4.save

pi4 = ProductIngredient.create
pi4.product_id = p10.id
pi4.ingredient_id = i4.id
pi4.save

i5 = Ingredient.find_or_create_by(name: "Chromium Oxide Greens")
i5.como_rating = nil
i5.save

pi5 = ProductIngredient.create
pi5.product_id = p10.id
pi5.ingredient_id = i5.id
pi5.save

i6 = Ingredient.find_or_create_by(name: "Fragrance")
i6.como_rating = nil
i6.save

pi6 = ProductIngredient.create
pi6.product_id = p10.id
pi6.ingredient_id = i6.id
pi6.save

i7 = Ingredient.find_or_create_by(name: "Phenoxyethanol")
i7.como_rating = nil
i7.save

pi7 = ProductIngredient.create
pi7.product_id = p10.id
pi7.ingredient_id = i7.id
pi7.save

i8 = Ingredient.find_or_create_by(name: "Methylparaben")
i8.como_rating = 0
i8.save