cards = randperm(52);
deck = Card.empty


for i = cards
    number = i;
    image = i + ".png";
    deck = cat(2,deck,Card(number,image))
end 

