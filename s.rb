require 'open-uri'
require 'nokogiri'

def readNews(url)
	doc = Nokogiri::HTML(open(url))
	
	#puts url	

	title = getTitle doc
	content = getContent doc
	subTitle = getSubTitle doc
	moreInfo = getMoreInfo doc
	image = getImage doc
	
	if false
	if(image)
	 puts title, subTitle, moreInfo, content, image[:url], image[:caption]
	else
	 puts title, subTitle, moreInfo, content
	end
	end
	
end

def getImage(doc)

	url = nil
	caption = nil

	images = doc.xpath("//img[@class='mb10']")

	if(images.first)
		url = images.first["src"].strip
		if(images.first["alt"])
			caption = images.first["alt"].strip
		end
	end	

	if(url)
		{:url => url, :caption => caption}
	end
end

def getSubTitle(doc)
	subTitle = doc.xpath("//h3[@class='shoulder']")
	if(subTitle.first)
		subTitle.first.text.strip
	end
end

def getMoreInfo(doc)
	moreInfo = doc.xpath("//p[@class='authorInfo mb10']")
	if(moreInfo.first)
		moreInfo.first.text.strip
	end
end

def getTitle(doc)
	title = doc.xpath('//h2[@class="title mb10"]')
	if(title.first)
		title.first.text.strip
	end
end

def getContent(doc)
	content = doc.xpath("//p[@id='content']")
	if(content.first)
		content.first.text.strip
	end
end

doc = Nokogiri::HTML(open("http://www.prothom-alo.com/"))
doc.xpath('//h2/a').each do |node|
	readNews("http://www.prothom-alo.com#{node['href']}")
end

