class Scrape
    
    attr_accessor :title, :hotness, :image_url, :rating, :director, :genre, :release_date, :runtime, :synopsis, :failure
    
    def scrape_new_movie
        begin 
            doc = Nokogiri::HTML(open("https://www.rottentomatoes.com/m/the_martian"))
            
            docs.css('script').remove
            self.title = doc.at("//h1[@data-type = 'title']").text
            self.hotness = doc.at("#tomato_meter_link/span/span").text.to_i
            self.image_url = doc.at_css('#movie-image-section img')['src']
            self.rating = doc.at("/html/body[@class='body  ']/div[@class='body_main container']/div[@id='main_container']/div[@id='mainColumn']/section[@class='panel panel-rt panel-box movie_info media']/div[@class='media-body']/div[@class='panel-body content_body']/div[@class='info']/div[@class='col col-sm-19 col-xs-14 text-left'][1]").text
            self.director = doc.at("/html/body[@class='body  ']/div[@class='body_main container']/div[@id='main_container']/div[@id='mainColumn']/section[@class='panel panel-rt panel-box movie_info media']/div[@class='media-body']/div[@class='panel-body content_body']/div[@class='info']/div[@class='col-sm-19 col-xs-14 text-left'][1]/a/span").text
            self.genre = doc.at("/html/body[@class='body  ']/div[@class='body_main container']/div[@id='main_container']/div[@id='mainColumn']/section[@class='panel panel-rt panel-box movie_info media']/div[@class='media-body']/div[@class='panel-body content_body']/div[@class='info']/div[@class='col col-sm-19 col-xs-14 text-left'][2]/*/span").text
            self.release_date = doc.at("/html/body[@class='body  ']/div[@class='body_main container']/div[@id='main_container']/div[@id='mainColumn']/section[@class='panel panel-rt panel-box movie_info media']/div[@class='media-body']/div[@class='panel-body content_body']/div[@class='info']/div[@class='col-sm-19 col-xs-14 text-left'][3]/time").text.to_date
            self.runtime = doc.at("/html/body[@class='body  ']/div[@class='body_main container']/div[@id='main_container']/div[@id='mainColumn']/section[@class='panel panel-rt panel-box movie_info media']/div[@class='media-body']/div[@class='panel-body content_body']/div[@class='info']/div[@class='col col-sm-19 col-xs-14 text-left'][4]/time").text
            self.synopsis = doc.css("#movieSynopsis").text
            return true
        rescue Exception => e
            self.failure = "Something went wrong with the scrape"
        end
    end
    
end