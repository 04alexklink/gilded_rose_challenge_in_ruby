require 'gilded_rose'

describe Item do
  it 'should take an item and print out its name, quality and sellin values as a string' do
    item = Item.new("Rubicon", 12, 49)
    expect(item.to_s()).to eq("Rubicon, 12, 49")
  end
end

describe GildedRose do
  describe 'normal items' do
    it 'quality should not be above 50' do
      watermelon = Item.new("Watermelon",5,55)
      gildedrose = GildedRose.new([watermelon])
      gildedrose.update_quality
      expect(watermelon.quality).to eq(54)
      expect(watermelon.sell_in).to eq(4)
      # quality can be above 50 if inputted above 50... am i being pedantic or is that an edge case?
    end

    it 'whilst sellin >0, quality should decrease by 1' do
      watermelon = Item.new("Watermelon",5,5)
      gildedrose = GildedRose.new([watermelon])
      gildedrose.update_quality
      expect(watermelon.quality).to eq(4)
      expect(watermelon.sell_in).to eq(4)
    end
    it 'when sellin < 0, quality should decrease by 2' do
      watermelon = Item.new("Watermelon",0,5)
      gildedrose = GildedRose.new([watermelon])
      gildedrose.update_quality
      expect(watermelon.quality).to eq(3)
      expect(watermelon.sell_in).to eq(-1)
    end
    it 'quality should not go below 0' do
      watermelon = Item.new("Watermelon",5,1)
      gildedrose = GildedRose.new([watermelon])
      gildedrose.update_quality
      gildedrose.update_quality
      expect(watermelon.quality).to eq(0)
      expect(watermelon.sell_in).to eq(3)
    end
  end

  describe 'Sulfuras'do
    it 'sulfuras items never have to be sold or decrease in quality' do
      sulfuras = Item.new("Sulfuras, Hand of Ragnaros",-5,-20)
      gildedrose = GildedRose.new([sulfuras])
      gildedrose.update_quality
      expect(sulfuras.quality).to eq(-20)
      expect(sulfuras.sell_in).to eq(-5)
      #this should fail because quality of any item should not be able to be negative!
    end
    it 'sulfuras items never have to be sold or decrease in quality' do
      sulfuras = Item.new("Sulfuras, Hand of Ragnaros",10,20)
      gildedrose = GildedRose.new([sulfuras])
      gildedrose.update_quality
      expect(sulfuras.quality).to eq(20)
      expect(sulfuras.sell_in).to eq(10)
    end
  end
  describe 'aged brie' do
    it 'quality increases in value by 1 the older it gets when sell-in value greater than 0' do
      aged_brie = Item.new("Aged Brie",5,10)
      gildedrose = GildedRose.new([aged_brie])
      gildedrose.update_quality
      expect(aged_brie.sell_in).to eq(4)
      expect(aged_brie.quality).to eq(11)
    end
    it 'quality increases in value the older it gets but capped at quality of 50' do
      aged_brie = Item.new("Aged Brie",5,49)
      gildedrose = GildedRose.new([aged_brie])
      gildedrose.update_quality
      gildedrose.update_quality
      expect(aged_brie.sell_in).to eq(3)
      expect(aged_brie.quality).to eq(50)
    end
    it 'quality increases by 2 once sell-in reaches 0' do
      aged_brie = Item.new("Aged Brie",1,40)
      gildedrose = GildedRose.new([aged_brie])
      gildedrose.update_quality
      gildedrose.update_quality
      gildedrose.update_quality
      expect(aged_brie.sell_in).to eq(-2)
      expect(aged_brie.quality).to eq(45)
      # it doesn't actually say that quality should increase by 2 when sell-in becomes negative... is this correct?
    end
  end
  describe 'Backstage passes' do
    it 'increases in quality by 1 when sell in >10' do
      backstage_passes = Item.new("Backstage passes to a TAFKAL80ETC concert",15,11)
      gildedrose = GildedRose.new([backstage_passes])
      gildedrose.update_quality
      expect(backstage_passes.sell_in).to eq(14)
      expect(backstage_passes.quality).to eq(12)
    end
    it 'increases in quality by 2 when sell in >=10 and sell in > 5' do
      backstage_passes = Item.new("Backstage passes to a TAFKAL80ETC concert",10,11)
      gildedrose = GildedRose.new([backstage_passes])
      gildedrose.update_quality
      expect(backstage_passes.sell_in).to eq(9)
      expect(backstage_passes.quality).to eq(13)
    end
    it 'increases in quality by 3 when sell in <= 5' do
      backstage_passes = Item.new("Backstage passes to a TAFKAL80ETC concert",5,11)
      gildedrose = GildedRose.new([backstage_passes])
      gildedrose.update_quality
      expect(backstage_passes.sell_in).to eq(4)
      expect(backstage_passes.quality).to eq(14)
    end
    it 'quality goes to 0 when sell in =0' do
      backstage_passes = Item.new("Backstage passes to a TAFKAL80ETC concert",0,15)
      gildedrose = GildedRose.new([backstage_passes])
      gildedrose.update_quality
      expect(backstage_passes.sell_in).to eq(-1)
      expect(backstage_passes.quality).to eq(0)
    end
    it 'quality increases in value the older it gets but capped at quality of 50' do
      backstage_passes = Item.new("Backstage passes to a TAFKAL80ETC concert",3,49)
      gildedrose = GildedRose.new([backstage_passes])
      gildedrose.update_quality
      gildedrose.update_quality
      expect(backstage_passes.sell_in).to eq(1)
      expect(backstage_passes.quality).to eq(50)
    end
    
  end
end