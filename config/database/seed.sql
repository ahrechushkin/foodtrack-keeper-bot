INSERT INTO categories (name, description) VALUES
    ('Coffee', 'Coffee is a brewed drink prepared from roasted coffee beans, the seeds of berries from certain Coffea species.'),
    ('Pizza', 'Yummy hot neapolitan pizza!'),
    ('Chocolate', 'The great dessert for coffee!');

INSERT INTO items (name, description, cost, category_id) VALUES
    ('Capuchino M-size', 'Espresso + Milk', 3.0, (SELECT id from categories WHERE name = 'Coffee')),
    ('Capuchino L-size', 'Espresso + Milk', 4.0, (SELECT id from categories WHERE name = 'Coffee')),
    ('Margaritta', 'The great base pizza with cheese', 14.0, (SELECT id from categories WHERE name = 'Pizza')),
    ('BBQ', 'Pizza with meat and bbq sauce', 16.0, (SELECT id from categories WHERE name = 'Pizza')),
    ('Mars', 'Nuga + chocolate', 2.0, (SELECT id from categories WHERE name = 'Chocolate')),
    ('MilkyWay', 'Nuga + milk chocolate', 2.2, (SELECT id from categories WHERE name = 'Chocolate'));