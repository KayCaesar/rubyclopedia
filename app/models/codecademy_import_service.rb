=begin
Copyright (C) 2013 Camille Baldock
Rubyclopedia is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.
Rubyclopedia is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.
You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
=end
require 'open-uri'
class CodecademyImportService
  def process_courses url = "http://www.codecademy.com/tracks/ruby"
    doc=Nokogiri::HTML(open(url))
    courses = doc.css('a.course-item')
    courses.each do |course|
      episode = Article.new(
        :free => true,
        :supplier => Article::CODECADEMY,
        :name => course.css('h4.course-item__title').text.strip,
        :description => course.css('p.course-item__entry').text.strip,
        :medium => Article::COURSE,
        :video_link => course.attr('href'))
      episode.save
    end
  end
end