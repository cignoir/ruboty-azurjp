require 'nokogiri'
require 'open-uri'
require 'terminal-table'
require 'kconv'

module Ruboty
  module Handlers
    class Azurjp < Base
      on(
          /(az|azur|azurlane)\s+?(?<keyword>.*?)\z/i,
          name: 'search',
          description: 'Azurlane helper'
      )

      def search(message)
        headings = []
        rows = []
        keywords = Kconv.toutf8(message[:keyword]).split(' ')

        uri = 'http://azurlane.wikiru.jp/index.php?%A5%AD%A5%E3%A5%E9%A5%AF%A5%BF%A1%BC%A5%EA%A5%B9%A5%C8'
        open(uri, 'r:EUC-JP') do |data|
          doc = Nokogiri::HTML(data)
          table = doc.xpath('//table[@id="sortabletable1"]')
          table_header = table.children.take(1).first
          table_body = table.children.drop(1)

          headings = table_header.children.map(&:children).map(&:children).flatten.map(&:text).take(15)

          table_body.each do |row|
            row.children.each do |tr|
              tmp = tr.children.map(&:text)
              rows << tmp.take(15) unless keywords.map{ |word| tmp.join.gsub('ﾛｲﾔﾙ', 'ロイヤル').gsub('ﾕﾆｵﾝ', 'ユニオン').include?(word) }.include?(false)
            end
          end
        end

        table = Terminal::Table.new(headings: headings, rows: rows)
        message.reply("```#{table}```")
      end
    end
  end
end
