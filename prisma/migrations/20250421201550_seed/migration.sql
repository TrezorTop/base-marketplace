-- Truncate tables for idempotency (cascade to handle foreign key constraints)
TRUNCATE TABLE "Trait" CASCADE;
TRUNCATE TABLE "Product" CASCADE;
TRUNCATE TABLE "Category" CASCADE;

-- Insert Categories
INSERT INTO "Category" ("id", "createdAt", "updatedAt", "name", "title")
VALUES
    ('550e8400-e29b-41d4-a716-446655440001', '2025-04-15 10:00:00+00', '2025-04-15 10:00:00+00', 'electronics', 'Electronics'),
    ('550e8400-e29b-41d4-a716-446655440002', '2025-04-16 12:00:00+00', '2025-04-16 12:00:00+00', 'clothing', 'Clothing'),
    ('550e8400-e29b-41d4-a716-446655440003', '2025-04-17 14:00:00+00', '2025-04-17 14:00:00+00', 'furniture', 'Furniture');

-- Insert Traits
INSERT INTO "Trait" ("id", "createdAt", "updatedAt", "name", "title", "categoryId")
VALUES
    -- Electronics Traits
    ('f1a2b3c4-d5e6-7890-abcd-123456789001', '2025-04-15 10:10:00+00', '2025-04-15 10:10:00+00', 'color', 'Color',
     '550e8400-e29b-41d4-a716-446655440001'),
    ('f1a2b3c4-d5e6-7890-abcd-123456789002', '2025-04-15 10:15:00+00', '2025-04-15 10:15:00+00', 'storage', 'Storage',
     '550e8400-e29b-41d4-a716-446655440001'),
    ('f1a2b3c4-d5e6-7890-abcd-123456789008', '2025-04-15 10:20:00+00', '2025-04-15 10:20:00+00', 'brand', 'Brand',
     '550e8400-e29b-41d4-a716-446655440001'),
    ('f1a2b3c4-d5e6-7890-abcd-123456789009', '2025-04-15 10:25:00+00', '2025-04-15 10:25:00+00', 'batteryLife', 'Battery Life',
     '550e8400-e29b-41d4-a716-446655440001'),
    ('f1a2b3c4-d5e6-7890-abcd-123456789010', '2025-04-15 10:30:00+00', '2025-04-15 10:30:00+00', 'screenSize', 'Screen Size',
     '550e8400-e29b-41d4-a716-446655440001'),
    ('f1a2b3c4-d5e6-7890-abcd-123456789011', '2025-04-15 10:35:00+00', '2025-04-15 10:35:00+00', 'connectivity', 'Connectivity',
     '550e8400-e29b-41d4-a716-446655440001'),
    ('f1a2b3c4-d5e6-7890-abcd-123456789012', '2025-04-15 10:40:00+00', '2025-04-15 10:40:00+00', 'warranty', 'Warranty',
     '550e8400-e29b-41d4-a716-446655440001'),
    -- Clothing Traits
    ('f1a2b3c4-d5e6-7890-abcd-123456789003', '2025-04-16 12:10:00+00', '2025-04-16 12:10:00+00', 'color', 'Color',
     '550e8400-e29b-41d4-a716-446655440002'),
    ('f1a2b3c4-d5e6-7890-abcd-123456789004', '2025-04-16 12:15:00+00', '2025-04-16 12:15:00+00', 'size', 'Size',
     '550e8400-e29b-41d4-a716-446655440002'),
    ('f1a2b3c4-d5e6-7890-abcd-123456789005', '2025-04-16 12:20:00+00', '2025-04-16 12:20:00+00', 'material', 'Material',
     '550e8400-e29b-41d4-a716-446655440002'),
    ('f1a2b3c4-d5e6-7890-abcd-123456789013', '2025-04-16 12:25:00+00', '2025-04-16 12:25:00+00', 'brand', 'Brand',
     '550e8400-e29b-41d4-a716-446655440002'),
    ('f1a2b3c4-d5e6-7890-abcd-123456789014', '2025-04-16 12:30:00+00', '2025-04-16 12:30:00+00', 'fit', 'Fit',
     '550e8400-e29b-41d4-a716-446655440002'),
    ('f1a2b3c4-d5e6-7890-abcd-123456789015', '2025-04-16 12:35:00+00', '2025-04-16 12:35:00+00', 'gender', 'Gender',
     '550e8400-e29b-41d4-a716-446655440002'),
    ('f1a2b3c4-d5e6-7890-abcd-123456789016', '2025-04-16 12:40:00+00', '2025-04-16 12:40:00+00', 'careInstructions', 'Care Instructions',
     '550e8400-e29b-41d4-a716-446655440002'),
    -- Furniture Traits
    ('f1a2b3c4-d5e6-7890-abcd-123456789006', '2025-04-17 14:10:00+00', '2025-04-17 14:10:00+00', 'material', 'Material',
     '550e8400-e29b-41d4-a716-446655440003'),
    ('f1a2b3c4-d5e6-7890-abcd-123456789007', '2025-04-17 14:15:00+00', '2025-04-17 14:15:00+00', 'color', 'Color',
     '550e8400-e29b-41d4-a716-446655440003'),
    ('f1a2b3c4-d5e6-7890-abcd-123456789017', '2025-04-17 14:20:00+00', '2025-04-17 14:20:00+00', 'brand', 'Brand',
     '550e8400-e29b-41d4-a716-446655440003'),
    ('f1a2b3c4-d5e6-7890-abcd-123456789018', '2025-04-17 14:25:00+00', '2025-04-17 14:25:00+00', 'dimensions', 'Dimensions',
     '550e8400-e29b-41d4-a716-446655440003'),
    ('f1a2b3c4-d5e6-7890-abcd-123456789019', '2025-04-17 14:30:00+00', '2025-04-17 14:30:00+00', 'style', 'Style',
     '550e8400-e29b-41d4-a716-446655440003'),
    ('f1a2b3c4-d5e6-7890-abcd-123456789020', '2025-04-17 14:35:00+00', '2025-04-17 14:35:00+00', 'assemblyRequired', 'Assembly Required',
     '550e8400-e29b-41d4-a716-446655440003'),
    ('f1a2b3c4-d5e6-7890-abcd-123456789021', '2025-04-17 14:40:00+00', '2025-04-17 14:40:00+00', 'weightCapacity', 'Weight Capacity',
     '550e8400-e29b-41d4-a716-446655440003');

-- Insert Products for Electronics
INSERT INTO "Product" ("id", "createdAt", "updatedAt", "name", "description", "price", "categoryId", "traits", "image")
VALUES
    ('a1b2c3d4-e5f6-7890-abcd-123456789001', '2025-04-15 11:00:00+00', '2025-04-15 11:00:00+00', 'Smartphone X',
     'Latest 5G smartphone with OLED display and triple camera', 699.99, '550e8400-e29b-41d4-a716-446655440001',
     '{"color": {"name": "color", "title": "Color", "value": "Black"}, "storage": {"name": "storage", "title": "Storage", "value": "128GB"}, "brand": {"name": "brand", "title": "Brand", "value": "TechTrend"}, "batteryLife": {"name": "batteryLife", "title": "Battery Life", "value": "24 hours"}, "screenSize": {"name": "screenSize", "title": "Screen Size", "value": "6.7 inches"}, "connectivity": {"name": "connectivity", "title": "Connectivity", "value": "5G"}, "warranty": {"name": "warranty", "title": "Warranty", "value": "2 years"}}',
     'placeholder.png'),
    ('a1b2c3d4-e5f6-7890-abcd-123456789002', '2025-04-15 11:30:00+00', '2025-04-15 11:30:00+00', 'Wireless Earbuds',
     'True wireless earbuds with noise cancellation', 149.99, '550e8400-e29b-41d4-a716-446655440001',
     '{"color": {"name": "color", "title": "Color", "value": "White"}, "storage": {"name": "storage", "title": "Storage", "value": "N/A"}, "brand": {"name": "brand", "title": "Brand", "value": "Sound Wave"}, "batteryLife": {"name": "batteryLife", "title": "Battery Life", "value": "20 hours"}, "screenSize": {"name": "screenSize", "title": "Screen Size", "value": "N/A"}, "connectivity": {"name": "connectivity", "title": "Connectivity", "value": "Bluetooth"}, "warranty": {"name": "warranty", "title": "Warranty", "value": "1 year"}}',
     'placeholder.png'),
    ('a1b2c3d4-e5f6-7890-abcd-123456789003', '2025-04-15 12:00:00+00', '2025-04-15 12:00:00+00', '4K Smart TV',
     '55-inch LED TV with streaming apps and HDR', 499.99, '550e8400-e29b-41d4-a716-446655440001',
     '{"color": {"name": "color", "title": "Color", "value": "Black"}, "storage": {"name": "storage", "title": "Storage", "value": "N/A"}, "brand": {"name": "brand", "title": "Brand", "value": "Vision Tech"}, "batteryLife": {"name": "batteryLife", "title": "Battery Life", "value": "N/A"}, "screenSize": {"name": "screenSize", "title": "Screen Size", "value": "55 inches"}, "connectivity": {"name": "connectivity", "title": "Connectivity", "value": "Wi-Fi"}, "warranty": {"name": "warranty", "title": "Warranty", "value": "3 years"}}',
     'placeholder.png'),
    ('a1b2c3d4-e5f6-7890-abcd-123456789004', '2025-04-15 12:30:00+00', '2025-04-15 12:30:00+00', 'Laptop Pro',
     'High-performance laptop with 16GB RAM and 512GB SSD', 1299.99, '550e8400-e29b-41d4-a716-446655440001',
     '{"color": {"name": "color", "title": "Color", "value": "Silver"}, "storage": {"name": "storage", "title": "Storage", "value": "512GB"}, "brand": {"name": "brand", "title": "Brand", "value": "ComputePro"}, "batteryLife": {"name": "batteryLife", "title": "Battery Life", "value": "10 hours"}, "screenSize": {"name": "screenSize", "title": "Screen Size", "value": "15.6 inches"}, "connectivity": {"name": "connectivity", "title": "Connectivity", "value": "Wi-Fi"}, "warranty": {"name": "warranty", "title": "Warranty", "value": "2 years"}}',
     'placeholder.png'),
    ('a1b2c3d4-e5f6-7890-abcd-123456789005', '2025-04-15 13:00:00+00', '2025-04-15 13:00:00+00', 'Smart Watch',
     'Fitness tracker with heart rate monitor and GPS', 199.99, '550e8400-e29b-41d4-a716-446655440001',
     '{"color": {"name": "color", "title": "Color", "value": "Black"}, "storage": {"name": "storage", "title": "Storage", "value": "N/A"}, "brand": {"name": "brand", "title": "Brand", "value": "FitTech"}, "batteryLife": {"name": "batteryLife", "title": "Battery Life", "value": "48 hours"}, "screenSize": {"name": "screenSize", "title": "Screen Size", "value": "1.5 inches"}, "connectivity": {"name": "connectivity", "title": "Connectivity", "value": "Bluetooth"}, "warranty": {"name": "warranty", "title": "Warranty", "value": "1 year"}}',
     'placeholder.png');

-- Insert Products for Clothing
INSERT INTO "Product" ("id", "createdAt", "updatedAt", "name", "description", "price", "categoryId", "traits", "image")
VALUES
    ('a1b2c3d4-e5f6-7890-abcd-123456789006', '2025-04-16 13:00:00+00', '2025-04-16 13:00:00+00', 'Cotton T-Shirt',
     'Breathable casual t-shirt for everyday wear', 19.99, '550e8400-e29b-41d4-a716-446655440002',
     '{"color": {"name": "color", "title": "Color", "value": "Blue"}, "size": {"name": "size", "title": "Size", "value": "M"}, "material": {"name": "material", "title": "Material", "value": "Cotton"}, "brand": {"name": "brand", "title": "Brand", "value": "Casual Wear"}, "fit": {"name": "fit", "title": "Fit", "value": "Regular"}, "gender": {"name": "gender", "title": "Gender", "value": "Unisex"}, "careInstructions": {"name": "careInstructions", "title": "Care Instructions", "value": "Machine Wash"}}',
     'placeholder.png'),
    ('a1b2c3d4-e5f6-7890-abcd-123456789007', '2025-04-16 13:30:00+00', '2025-04-16 13:30:00+00', 'Denim Jeans',
     'Slim-fit jeans with stretch fabric', 49.99, '550e8400-e29b-41d4-a716-446655440002',
     '{"color": {"name": "color", "title": "Color", "value": "Dark Blue"}, "size": {"name": "size", "title": "Size", "value": "32"}, "material": {"name": "material", "title": "Material", "value": "Denim"}, "brand": {"name": "brand", "title": "Brand", "value": "Denim Co"}, "fit": {"name": "fit", "title": "Fit", "value": "Slim"}, "gender": {"name": "gender", "title": "Gender", "value": "Men"}, "careInstructions": {"name": "careInstructions", "title": "Care Instructions", "value": "Machine Wash"}}',
     'placeholder.png'),
    ('a1b2c3d4-e5f6-7890-abcd-123456789008', '2025-04-16 14:00:00+00', '2025-04-16 14:00:00+00', 'Wool Sweater',
     'Warm sweater for winter with ribbed cuffs', 59.99, '550e8400-e29b-41d4-a716-446655440002',
     '{"color": {"name": "color", "title": "Color", "value": "Gray"}, "size": {"name": "size", "title": "Size", "value": "L"}, "material": {"name": "material", "title": "Material", "value": "Wool"}, "brand": {"name": "brand", "title": "Brand", "value": "Warm Wear"}, "fit": {"name": "fit", "title": "Fit", "value": "Loose"}, "gender": {"name": "gender", "title": "Gender", "value": "Women"}, "careInstructions": {"name": "careInstructions", "title": "Care Instructions", "value": "Dry Clean"}}',
     'placeholder.png'),
    ('a1b2c3d4-e5f6-7890-abcd-123456789009', '2025-04-16 14:30:00+00', '2025-04-16 14:30:00+00', 'Leather Jacket',
     'Premium leather jacket with zipper and side pockets', 129.99, '550e8400-e29b-41d4-a716-446655440002',
     '{"color": {"name": "color", "title": "Color", "value": "Black"}, "size": {"name": "size", "title": "Size", "value": "M"}, "material": {"name": "material", "title": "Material", "value": "Leather"}, "brand": {"name": "brand", "title": "Brand", "value": "LuxWear"}, "fit": {"name": "fit", "title": "Fit", "value": "Regular"}, "gender": {"name": "gender", "title": "Gender", "value": "Men"}, "careInstructions": {"name": "careInstructions", "title": "Care Instructions", "value": "Wipe Clean"}}',
     'placeholder.png'),
    ('a1b2c3d4-e5f6-7890-abcd-123456789010', '2025-04-16 15:00:00+00', '2025-04-16 15:00:00+00', 'Sneakers',
     'Comfortable running shoes with cushioned soles', 79.99, '550e8400-e29b-41d4-a716-446655440002',
     '{"color": {"name": "color", "title": "Color", "value": "White"}, "size": {"name": "size", "title": "Size", "value": "10"}, "material": {"name": "material", "title": "Material", "value": "Synthetic"}, "brand": {"name": "brand", "title": "Brand", "value": "Run Fast"}, "fit": {"name": "fit", "title": "Fit", "value": "Athletic"}, "gender": {"name": "gender", "title": "Gender", "value": "Unisex"}, "careInstructions": {"name": "careInstructions", "title": "Care Instructions", "value": "Machine Wash"}}',
     'placeholder.png'),
    ('a1b2c3d4-e5f6-7890-abcd-123456789011', '2025-04-16 15:30:00+00', '2025-04-16 15:30:00+00', 'Baseball Cap',
     'Adjustable cap with embroidered logo', 24.99, '550e8400-e29b-41d4-a716-446655440002',
     '{"color": {"name": "color", "title": "Color", "value": "Red"}, "size": {"name": "size", "title": "Size", "value": "One Size"}, "material": {"name": "material", "title": "Material", "value": "Cotton"}, "brand": {"name": "brand", "title": "Brand", "value": "Sporty"}, "fit": {"name": "fit", "title": "Fit", "value": "Regular"}, "gender": {"name": "gender", "title": "Gender", "value": "Unisex"}, "careInstructions": {"name": "careInstructions", "title": "Care Instructions", "value": "Machine Wash"}}',
     'placeholder.png');

-- Insert Products for Furniture
INSERT INTO "Product" ("id", "createdAt", "updatedAt", "name", "description", "price", "categoryId", "traits", "image")
VALUES
    ('a1b2c3d4-e5f6-7890-abcd-123456789012', '2025-04-17 15:00:00+00', '2025-04-17 15:00:00+00', 'Wooden Dining Table',
     'Solid oak table for 6 with smooth finish', 399.99, '550e8400-e29b-41d4-a716-446655440003',
     '{"material": {"name": "material", "title": "Material", "value": "OAK"}, "color": {"name": "color", "title": "Color", "value": "Brown"}, "brand": {"name": "brand", "title": "Brand", "value": "WoodCraft"}, "dimensions": {"name": "dimensions", "title": "Dimensions", "value": "180x90x75 cm"}, "style": {"name": "style", "title": "Style", "value": "Rustic"}, "assemblyRequired": {"name": "assemblyRequired", "title": "Assembly Required", "value": "Yes"}, "weightCapacity": {"name": "weightCapacity", "title": "Weight Capacity", "value": "500 kg"}}',
     'placeholder.png'),
    ('a1b2c3d4-e5f6-7890-abcd-123456789013', '2025-04-17 15:30:00+00', '2025-04-17 15:30:00+00', 'Leather Sofa',
     'Three-seater with recliner and soft leather', 899.99, '550e8400-e29b-41d4-a716-446655440003',
     '{"material": {"name": "material", "title": "Material", "value": "Leather"}, "color": {"name": "color", "title": "Color", "value": "Brown"}, "brand": {"name": "brand", "title": "Brand", "value": "Comfy Home"}, "dimensions": {"name": "dimensions", "title": "Dimensions", "value": "200x90x85 cm"}, "style": {"name": "style", "title": "Style", "value": "Modern"}, "assemblyRequired": {"name": "assemblyRequired", "title": "Assembly Required", "value": "No"}, "weightCapacity": {"name": "weightCapacity", "title": "Weight Capacity", "value": "300 kg"}}',
     'placeholder.png'),
    ('a1b2c3d4-e5f6-7890-abcd-123456789014', '2025-04-17 16:00:00+00', '2025-04-17 16:00:00+00', 'Bookshelf',
     'Five-shelf pine bookshelf for storage', 149.99, '550e8400-e29b-41d4-a716-446655440003',
     '{"material": {"name": "material", "title": "Material", "value": "Pine"}, "color": {"name": "color", "title": "Color", "value": "Natural"}, "brand": {"name": "brand", "title": "Brand", "value": "Storage Solutions"}, "dimensions": {"name": "dimensions", "title": "Dimensions", "value": "80x30x180 cm"}, "style": {"name": "style", "title": "Style", "value": "Rustic"}, "assemblyRequired": {"name": "assemblyRequired", "title": "Assembly Required", "value": "Yes"}, "weightCapacity": {"name": "weightCapacity", "title": "Weight Capacity", "value": "100 kg"}}',
     'placeholder.png'),
    ('a1b2c3d4-e5f6-7890-abcd-123456789015', '2025-04-17 16:30:00+00', '2025-04-17 16:30:00+00', 'Coffee Table',
     'Glass top with metal frame and modern design', 199.99, '550e8400-e29b-41d4-a716-446655440003',
     '{"material": {"name": "material", "title": "Material", "value": "Glass/Metal"}, "color": {"name": "color", "title": "Color", "value": "Silver"}, "brand": {"name": "brand", "title": "Brand", "value": "Modern Living"}, "dimensions": {"name": "dimensions", "title": "Dimensions", "value": "120x60x40 cm"}, "style": {"name": "style", "title": "Style", "value": "modern"}, "assemblyRequired": {"name": "assemblyRequired", "title": "Assembly Required", "value": "Yes"}, "weightCapacity": {"name": "weightCapacity", "title": "Weight Capacity", "value": "50 kg"}}',
     'placeholder.png'),
    ('a1b2c3d4-e5f6-7890-abcd-123456789016', '2025-04-17 17:00:00+00', '2025-04-17 17:00:00+00', 'Office Chair',
     'Ergonomic with lumbar support and adjustable height', 249.99, '550e8400-e29b-41d4-a716-446655440003',
     '{"material": {"name": "material", "title": "Material", "value": "Mesh"}, "color": {"name": "color", "title": "Color", "value": "Black"}, "brand": {"name": "brand", "title": "Brand", "value": "ErgoSeat"}, "dimensions": {"name": "dimensions", "title": "Dimensions", "value": "60x60x110 cm"}, "style": {"name": "style", "title": "Style", "value": "Modern"}, "assemblyRequired": {"name": "assemblyRequired", "title": "Assembly Required", "value": "Yes"}, "weightCapacity": {"name": "weightCapacity", "title": "Weight Capacity", "value": "120 kg"}}',
     'placeholder.png'),
    ('a1b2c3d4-e5f6-7890-abcd-123456789017', '2025-04-17 17:30:00+00', '2025-04-17 17:30:00+00', 'Bed Frame',
     'Queen-size wooden frame with sturdy slats', 349.99, '550e8400-e29b-41d4-a716-446655440003',
     '{"material": {"name": "material", "title": "Material", "value": "Wood"}, "color": {"name": "color", "title": "Color", "value": "Brown"}, "brand": {"name": "brand", "title": "Brand", "value": "Sleep Well"}, "dimensions": {"name": "dimensions", "title": "Dimensions", "value": "200x160x40 cm"}, "style": {"name": "style", "title": "Style", "value": "Rustic"}, "assemblyRequired": {"name": "assemblyRequired", "title": "Assembly Required", "value": "Yes"}, "weightCapacity": {"name": "weightCapacity", "title": "Weight Capacity", "value": "400 kg"}}',
     'placeholder.png');
