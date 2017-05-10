namespace :export do
  desc "Prints Article.all in a seeds.rb way."
  task :seeds_format => :environment do
    Article.all.each do |article|
      puts "Article.create(#{article.serializable_hash.delete_if {|key, value| ['created_at','updated_at','id'].include?(key)}.to_s.gsub(/[{}]/,'')})"
    end
  end
end