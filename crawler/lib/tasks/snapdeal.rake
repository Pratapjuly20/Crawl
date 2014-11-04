task :fetch_content => :environment do
  mechanize = Mechanize.new
  page = mechanize.get('http://www.snapdeal.com/info/sitemap')
  #fetch_content(page)
  #feed(page)
  fetch_subcategory_content(page)
end




def fetch_content(page)
	byebug
	category_names = page.search("b").map(&:text).map(&:strip)
	category_names_length = category_names.length
	for i in 0..category_names_length-1
		Category.create(:name => category_names[i])
	end
end

def fetch_subcategory_content(page)
	byebug
	subcategory_names = page.search(".childCategorySiteMap").map(&:text).map(&:strip)
	subcategories = page.search(".childCategorySiteMap")
    subcategory_count = subcategories.count
    for i in 0..subcategory_count-1
      subcategory_link = subcategories[i].attributes["href"].value
      puts subcategory_names
    end
end

def feed(page)
	#byebug
	categories = Category.where(:parent_id => nil)
	categories_size = categories.count
	for i in 0..categories_size-1
		subcategory_names = page.search(".sitemap-line:nth-child(1) :nth-child(1) .sitemap-items .childCategorySiteMap").map(&:text).map(&:strip)
		subcategory_names_length = subcategory_names.count
		for j in 0..subcategory_names_length-1
			Category.create(:name => subcategory_names[j], :parent_id => categories[i].id)
		end
    end
end












