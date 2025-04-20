-- Truncate tables for idempotency (cascade to handle foreign key constraints)
TRUNCATE TABLE "Trait" CASCADE;
TRUNCATE TABLE "Product" CASCADE;
TRUNCATE TABLE "Category" CASCADE;

-- Insert Categories
INSERT INTO "Category" ("id", "createdAt", "updatedAt", "name", "title")
VALUES ('550e8400-e29b-41d4-a716-446655440001', '2025-04-15 10:00:00+00', '2025-04-15 10:00:00+00', 'electronics',
        'Electronics'),
       ('550e8400-e29b-41d4-a716-446655440002', '2025-04-16 12:00:00+00', '2025-04-16 12:00:00+00', 'clothing',
        'Clothing'),
       ('550e8400-e29b-41d4-a716-446655440003', '2025-04-17 14:00:00+00', '2025-04-17 14:00:00+00', 'furniture',
        'Furniture');

-- Insert Traits (2-3 per category)
INSERT INTO "Trait" ("id", "createdAt", "updatedAt", "name", "title", "categoryId")
VALUES ('f1a2b3c4-d5e6-7890-abcd-123456789001', '2025-04-15 10:10:00+00', '2025-04-15 10:10:00+00', 'color', 'Color',
        '550e8400-e29b-41d4-a716-446655440001'),
       ('f1a2b3c4-d5e6-7890-abcd-123456789002', '2025-04-15 10:15:00+00', '2025-04-15 10:15:00+00', 'storage',
        'Storage',
        '550e8400-e29b-41d4-a716-446655440001'),
       ('f1a2b3c4-d5e6-7890-abcd-123456789003', '2025-04-16 12:10:00+00', '2025-04-16 12:10:00+00', 'color', 'Color',
        '550e8400-e29b-41d4-a716-446655440002'),
       ('f1a2b3c4-d5e6-7890-abcd-123456789004', '2025-04-16 12:15:00+00', '2025-04-16 12:15:00+00', 'size', 'Size',
        '550e8400-e29b-41d4-a716-446655440002'),
       ('f1a2b3c4-d5e6-7890-abcd-123456789005', '2025-04-16 12:20:00+00', '2025-04-16 12:20:00+00', 'material',
        'Material',
        '550e8400-e29b-41d4-a716-446655440002'),
       ('f1a2b3c4-d5e6-7890-abcd-123456789006', '2025-04-17 14:10:00+00', '2025-04-17 14:10:00+00', 'material',
        'Material',
        '550e8400-e29b-41d4-a716-446655440003'),
       ('f1a2b3c4-d5e6-7890-abcd-123456789007', '2025-04-17 14:15:00+00', '2025-04-17 14:15:00+00', 'color', 'Color',
        '550e8400-e29b-41d4-a716-446655440003');

-- Insert Products for Electronics (5 products, all with descriptions)
INSERT INTO "Product" ("id", "createdAt", "updatedAt", "name", "description", "price", "categoryId", "traits")
VALUES ('a1b2c3d4-e5f6-7890-abcd-123456789001', '2025-04-15 11:00:00+00', '2025-04-15 11:00:00+00', 'Smartphone X',
        'Latest 5G smartphone with OLED display and triple camera', 699.99, '550e8400-e29b-41d4-a716-446655440001', '{
    "color": "black",
    "storage": "128GB"
  }'),
       ('a1b2c3d4-e5f6-7890-abcd-123456789002', '2025-04-15 11:30:00+00', '2025-04-15 11:30:00+00', 'Wireless Earbuds',
        'True wireless earbuds with noise cancellation', 149.99, '550e8400-e29b-41d4-a716-446655440001', '{
         "color": "white",
         "storage": "N/A"
       }'),
       ('a1b2c3d4-e5f6-7890-abcd-123456789003', '2025-04-15 12:00:00+00', '2025-04-15 12:00:00+00', '4K Smart TV',
        '55-inch LED TV with streaming apps and HDR', 499.99, '550e8400-e29b-41d4-a716-446655440001', '{
         "color": "black",
         "storage": "N/A"
       }'),
       ('a1b2c3d4-e5f6-7890-abcd-123456789004', '2025-04-15 12:30:00+00', '2025-04-15 12:30:00+00', 'Laptop Pro',
        'High-performance laptop with 16GB RAM and 512GB SSD', 1299.99, '550e8400-e29b-41d4-a716-446655440001', '{
         "color": "silver",
         "storage": "512GB"
       }'),
       ('a1b2c3d4-e5f6-7890-abcd-123456789005', '2025-04-15 13:00:00+00', '2025-04-15 13:00:00+00', 'Smart Watch',
        'Fitness tracker with heart rate monitor and GPS', 199.99, '550e8400-e29b-41d4-a716-446655440001', '{
         "color": "black",
         "storage": "N/A"
       }');

-- Insert Products for Clothing (6 products, all with descriptions)
INSERT INTO "Product" ("id", "createdAt", "updatedAt", "name", "description", "price", "categoryId", "traits")
VALUES ('a1b2c3d4-e5f6-7890-abcd-123456789006', '2025-04-16 13:00:00+00', '2025-04-16 13:00:00+00', 'Cotton T-Shirt',
        'Breathable casual t-shirt for everyday wear', 19.99, '550e8400-e29b-41d4-a716-446655440002', '{
    "color": "blue",
    "size": "M",
    "material": "cotton"
  }'),
       ('a1b2c3d4-e5f6-7890-abcd-123456789007', '2025-04-16 13:30:00+00', '2025-04-16 13:30:00+00', 'Denim Jeans',
        'Slim-fit jeans with stretch fabric', 49.99, '550e8400-e29b-41d4-a716-446655440002', '{
         "color": "dark blue",
         "size": "32",
         "material": "denim"
       }'),
       ('a1b2c3d4-e5f6-7890-abcd-123456789008', '2025-04-16 14:00:00+00', '2025-04-16 14:00:00+00', 'Wool Sweater',
        'Warm sweater for winter with ribbed cuffs', 59.99, '550e8400-e29b-41d4-a716-446655440002', '{
         "color": "gray",
         "size": "L",
         "material": "wool"
       }'),
       ('a1b2c3d4-e5f6-7890-abcd-123456789009', '2025-04-16 14:30:00+00', '2025-04-16 14:30:00+00', 'Leather Jacket',
        'Premium leather jacket with zipper and side pockets', 129.99, '550e8400-e29b-41d4-a716-446655440002', '{
         "color": "black",
         "size": "M",
         "material": "leather"
       }'),
       ('a1b2c3d4-e5f6-7890-abcd-123456789010', '2025-04-16 15:00:00+00', '2025-04-16 15:00:00+00', 'Sneakers',
        'Comfortable running shoes with cushioned soles', 79.99, '550e8400-e29b-41d4-a716-446655440002', '{
         "color": "white",
         "size": "10",
         "material": "synthetic"
       }'),
       ('a1b2c3d4-e5f6-7890-abcd-123456789011', '2025-04-16 15:30:00+00', '2025-04-16 15:30:00+00', 'Baseball Cap',
        'Adjustable cap with embroidered logo', 24.99, '550e8400-e29b-41d4-a716-446655440002', '{
         "color": "red",
         "size": "one-size",
         "material": "cotton"
       }');

-- Insert Products for Furniture (6 products, all with descriptions)
INSERT INTO "Product" ("id", "createdAt", "updatedAt", "name", "description", "price", "categoryId", "traits")
VALUES ('a1b2c3d4-e5f6-7890-abcd-123456789012', '2025-04-17 15:00:00+00', '2025-04-17 15:00:00+00',
        'Wooden Dining Table', 'Solid oak table for 6 with smooth finish', 399.99,
        '550e8400-e29b-41d4-a716-446655440003', '{
    "material": "oak",
    "color": "brown"
  }'),
       ('a1b2c3d4-e5f6-7890-abcd-123456789013', '2025-04-17 15:30:00+00', '2025-04-17 15:30:00+00', 'Leather Sofa',
        'Three-seater with recliner and soft leather', 899.99, '550e8400-e29b-41d4-a716-446655440003', '{
         "material": "leather",
         "color": "brown"
       }'),
       ('a1b2c3d4-e5f6-7890-abcd-123456789014', '2025-04-17 16:00:00+00', '2025-04-17 16:00:00+00', 'Bookshelf',
        'Five-shelf pine bookshelf for storage', 149.99, '550e8400-e29b-41d4-a716-446655440003', '{
         "material": "pine",
         "color": "natural"
       }'),
       ('a1b2c3d4-e5f6-7890-abcd-123456789015', '2025-04-17 16:30:00+00', '2025-04-17 16:30:00+00', 'Coffee Table',
        'Glass top with metal frame and modern design', 199.99, '550e8400-e29b-41d4-a716-446655440003', '{
         "material": "glass/metal",
         "color": "silver"
       }'),
       ('a1b2c3d4-e5f6-7890-abcd-123456789016', '2025-04-17 17:00:00+00', '2025-04-17 17:00:00+00', 'Office Chair',
        'Ergonomic with lumbar support and adjustable height', 249.99, '550e8400-e29b-41d4-a716-446655440003', '{
         "material": "mesh",
         "color": "black"
       }'),
       ('a1b2c3d4-e5f6-7890-abcd-123456789017', '2025-04-17 17:30:00+00', '2025-04-17 17:30:00+00', 'Bed Frame',
        'Queen-size wooden frame with sturdy slats', 349.99, '550e8400-e29b-41d4-a716-446655440003', '{
         "material": "wood",
         "color": "brown"
       }');