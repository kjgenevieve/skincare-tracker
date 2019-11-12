##################################
# Get all product links from site#
##################################

# def get_links(i)
#     i = 882
#     links = []
#     mechanize = Mechanize.new
    

#     while i <= 1043 do
#         # url = "https://www.skincarisma.com/search?page=#{i}"
#         url = "https://www.skincarisma.com/search?category=Face+Skincare&page=#{i}"
#         page = mechanize.get(url)

#         thingy = page.search('div.card div.card-body ul.list-unstyled a')
#         thingy.each do |thing|
#             thing.children.remove
#             product_link = thing.get_attribute('href')
#             if product_link != "#nogo" && product_link != "#"
#                 links << product_link
#             end
#         end
        
        
#         i += 1
        
#         puts "i: #{i}"
#         puts "==========================="

#         link = page.search('a.next_page')
        
        
#         if i < 1043
#             url
#         end

#         # page


        
#     end
#     links.uniq!
#     puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
#     puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
#     puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
#     puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
#     puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
#     puts links
# end

# get_links(1)

