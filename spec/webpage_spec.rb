# -*- encoding : utf-8 -*-

require File.join(File.dirname(__FILE__), '/spec_helper')

describe Readable::Webpage, 'Encoding' do
  it "should convert html into utf-8 according to charset of webpage" do
    stub_page!('pages/sohu.html')
    page = Readable::Webpage.new('http://test.com')
    page.html.encoding.name.downcase.should == 'utf-8'
  end
end

describe Readable::Webpage, "Parse" do
  it "should parse sohu correctly" do
    stub_page!('pages/sohu.html')
    page = Readable::Webpage.new('http://sohu.com')
    page.title.should == '揭秘玫瑰怒放四部曲 投射能力增强才是蜕变之源'
    page.content.should be_include('没错，德里克-罗斯是从小看着迈克尔-乔丹打球长大的，在他成为2008年的选秀状元之时，他也没想过自己能这么快达到如此高的巅峰，这也出乎了所有人的意料，因为完成这一切他仅仅用了3个赛季而以，本赛季的罗斯可谓一飞冲天，即便是他赛季之前就成宣称自己要成为“MVP”，人们也并没有把这句话放在心上。')
    page.content.should_not be_include('网友关注排行')
  end
  
  it "should parse qq news correctly" do
    stub_page!('pages/qq.html')
    page = Readable::Webpage.new('http://qq.com')
    page.title.should == '卡扎菲政府军发言人在北约空袭中死亡'
    page.content.should be_include('中新网5月16日电')
    page.content.should be_include('因为这些设施是卡扎菲政权维持统治的工具。')
    page.content.should_not be_include('每日推荐')
  end
  
  it "should parse sina news correctly" do
    stub_page!('pages/sina.html')
    page = Readable::Webpage.new('http://sina.com.cn')
    page.title.should == '巴基斯坦同意今日归还美绝密隐身直升机残骸'
    page.content.should be_include('环球网记者')
    page.content.should be_include('抵达展开准备工作')
    page.content.should_not be_include('军事论坛')
  end
  
  it "should parse techcrunch correctly" do
    stub_page!('pages/techcrunch.html')
    page = Readable::Webpage.new('http://techcrunch.com')
    page.title.should   be_include('Chrome OS 12')
    page.content.should be_include('Last week, just prior to day one of Google I/O')
    page.content.should be_include('what the first Chromebooks will feel like, check it out.')
    page.content.should_not be_include('Jobs')
  end
  
  it "should parse wordpress correctly" do
    stub_page!('pages/wordpress.html')
    page = Readable::Webpage.new('http://wordpress.com')
    page.title.should   be_include('My Weekend')
    page.content.should be_include('It is said that Greek people')
    page.content.should be_include('Kate')
    page.content.should_not be_include('You ARE a Goddess')
  end
end
