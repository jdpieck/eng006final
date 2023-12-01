cards = randperm(52);
deck = Card.empty


for i = cards
    number = i;
    image = i + ".svg";
    deck = cat(2,deck,Card(number,image))
end 

