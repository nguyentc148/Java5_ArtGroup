USE master 
GO
CREATE DATABASE N8RubikShop
GO
USE N8RubikShop

--  Người dùng 
CREATE TABLE UserCustom (
  user_id INT IDENTITY(100000, 1) PRIMARY KEY,
  username NVARCHAR(255) NOT NULL,
  password NVARCHAR(255) NOT NULL,	
  fullname NVARCHAR(70) NOT NULL,
  email NVARCHAR(255) NOT NULL,
  phone_number NVARCHAR(20) NOT NULL,
  address NVARCHAR(255) NOT NULL,
  isAdmin BIT NOT NULL DEFAULT 0,
  is_del BIT NOT NULL DEFAULT 0
);

--  Loại sản phẩm 
CREATE TABLE Category (
  category_id  INT IDENTITY(200000, 1) PRIMARY KEY,
  category_name NVARCHAR(255) NOT NULL,
  is_del BIT NOT NULL DEFAULT 0
);


-- Hãng sản phẩm
CREATE TABLE Manufacturer (
  manufacturer_id  INT IDENTITY(400000, 1) PRIMARY KEY,
  manufacturer_name NVARCHAR(255) NOT NULL,
  is_del BIT NOT NULL DEFAULT 0
);

--  Sản phẩm
CREATE TABLE Product (
  product_id INT IDENTITY(300000, 1) PRIMARY KEY,
  category_id INT NOT NULL,
  manufacturer_id INT NOT NULL,
  product_name NVARCHAR(255) NOT NULL,
  quantity_in_stock INT NOT NULL,
  original_price  DECIMAL(16, 2) NOT NULL,
  image NVARCHAR(250) NOT NULL,
  size NVARCHAR(50) NOT NULL,
  material NVARCHAR(50) NOT NULL,
  weight DECIMAL(5, 1) NOT NULL,
  color NVARCHAR(50) NOT NULL,
  description NVARCHAR(300) NOT NULL,
  is_del BIT NOT NULL DEFAULT 0,
  FOREIGN KEY (category_id) REFERENCES Category(category_id),
  FOREIGN KEY (manufacturer_id) REFERENCES Manufacturer(manufacturer_id)
);
--flash sale
CREATE TABLE FlashSale
(
	flashSale_id INT IDENTITY(990000, 1) PRIMARY KEY,
	start_day DATETIME NOT NULL,
	end_day DATETIME NOT NULL,
	is_status BIT NOT NULL
)

-- chi tiết khuyến mãi
CREATE TABLE PromotionalDetails (
  promotional_id INT IDENTITY(900000, 1) PRIMARY KEY,
  product_id INT NOT NULL,
  flashSale_id INT NOT NULL,
  discounted_price DECIMAL(16, 2) NOT NULL,
  promotion_status bit NOT NULL,
  FOREIGN KEY (product_id) REFERENCES Product (product_id),
  FOREIGN KEY (flashSale_ID) REFERENCES dbo.FlashSale (flashSale_ID)
);

--  Hóa đơn
CREATE TABLE Invoice (
  invoice_id INT IDENTITY(500000, 1) PRIMARY KEY,
  user_id INT NOT NULL,
  invoice_date DATETIME NOT NULL,
  total_amount DECIMAL(16, 2) NOT NULL,
  delivery_address NVARCHAR(250) NOT NULL,
  description NVARCHAR(250) NULL,
  FOREIGN KEY (user_id) REFERENCES UserCustom(user_id)
);

--  Hóa đơn chi tiết
CREATE TABLE InvoiceDetail (
  invoice_detail_id INT IDENTITY(600000, 1) PRIMARY KEY,
  invoice_id INT NOT NULL,
  product_id INT NOT NULL,
  quantity INT NOT NULL,
  price DECIMAL(16, 2) NOT NULL,
  FOREIGN KEY (invoice_id) REFERENCES Invoice(invoice_id),
  FOREIGN KEY (product_id) REFERENCES Product(product_id)
);

--  Danh sách sản phẩm yêu thích 
CREATE TABLE Wishlist (
  wishlist_id INT IDENTITY(700000, 1) PRIMARY KEY,
  user_id INT NOT NULL,
  product_id INT NOT NULL,
  wishlist_date DATE NOT NULL,
  FOREIGN KEY (user_id) REFERENCES UserCustom(user_id),
  FOREIGN KEY (product_id) REFERENCES Product(product_id)
);
--  Danh sách sản phẩm đã xem
CREATE TABLE RecentlyViewed (
  recently_viewed_id INT IDENTITY(800000, 1) PRIMARY KEY,
  user_id INT NOT NULL,
  product_id INT NOT NULL,
  viewed_date DATETIME NOT NULL,
  FOREIGN KEY (user_id) REFERENCES UserCustom(user_id),
  FOREIGN KEY (product_id) REFERENCES Product(product_id)
);

-- Giỏ hàng
CREATE TABLE Cart(
	cart_id INT IDENTITY(100000, 1) PRIMARY KEY,
	user_id INT NOT NULL,
	product_id INT NOT NULL,
	quantity INT NOT NULL DEFAULT 1
  FOREIGN KEY (user_id) REFERENCES UserCustom(user_id),
  FOREIGN KEY (product_id) REFERENCES Product(product_id)
)
INSERT INTO dbo.FlashSale
        ( start_day, end_day, is_status )
VALUES  ( '2023-08-02', -- start_day - datetime
          GETDATE(), -- end_day - datetime
          0  -- is_status - bit
          )
INSERT INTO dbo.Wishlist
        ( user_id ,
          product_id ,
          wishlist_date
        )
VALUES  ( 101012 , -- user_id - int
          300002 , -- product_id - int
          GETDATE()  -- wishlist_date - date
        )

--thêm dữ liệu

-- bảng hãng rubik
INSERT INTO dbo.Manufacturer
        ( manufacturer_name, is_del )
VALUES  ( N'GAN', -- manufacturer_name - nvarchar(255)
          0  -- is_del - bit
          ),
		  ( N'MOYU', -- manufacturer_name - nvarchar(255)
          0  -- is_del - bit
          ),
		  ( N'QIYI', -- manufacturer_name - nvarchar(255)
          0  -- is_del - bit
          ),
		  ( N'DAYAN', -- manufacturer_name - nvarchar(255)
          0  -- is_del - bit
          ),
		  ( N'YONGJUN', -- manufacturer_name - nvarchar(255)
          0  -- is_del - bit
          );
GO

-- Bảng loại Rubik
INSERT INTO dbo.Category
        ( category_name, is_del )
VALUES  ( N'3x3x3', -- category_name - nvarchar(255)
          0  -- is_del - bit
          ),
		  ( N'4x4x4', -- category_name - nvarchar(255)
          0  -- is_del - bit
          ),
		  ( N'5x5x5', -- category_name - nvarchar(255)
          0  -- is_del - bit
          ),
		  ( N'2x2x2', -- category_name - nvarchar(255)
          0  -- is_del - bit
          );
		  
GO

	-- sản phẩm GAN
INSERT INTO dbo.Product
        ( category_id ,manufacturer_id ,product_name ,quantity_in_stock ,original_price ,image ,size ,material ,weight ,color ,description ,is_del)
VALUES  --3x3x3
		( 200000 , -- category_id - int
          400000 , -- manufacturer_id - int
          N'[Rubik Thông Minh] Rubik Gan i Carry kết nối với điện thoại Stickerless (Có Nam Châm)' , -- product_name - nvarchar(255)
          100 , -- quantity_in_stock - int
          530000 , -- original_price - decimal(16, 2)
          N'gan3x3-anh1.png' , -- image - nvarchar(250)
          N'56mm x 56mm x 56mm' , -- size - nvarchar(50)
          N'Nhựa ABS cao cấp' , -- material - nvarchar(50)
          77.5 , -- weight - decimal(5, 1)
          N'Stickerless không viền' , -- color - nvarchar(50)
          N'Phiên bản nâng cấp tiếp theo của gan i với tính năng kết nối với điện thoại thông qua app Cube Station với tính năng 280h không cần sạc' , -- description - nvarchar(300)
          0  -- is_del - bit
        ),
		( 200000 , -- category_id - int
          400000 , -- manufacturer_id - int
          N' GAN 12 SERIES 3 Maglev UV/ Maglev Matte / Gan 12M LEAP Stickerless không viền' , -- product_name - nvarchar(255)
          100 , -- quantity_in_stock - int
          990000 , -- original_price - decimal(16, 2)
          N'gan3x3-anh2.png' , -- image - nvarchar(250)
          N'56mm x 56mm x 56mm' , -- size - nvarchar(50)
          N'Nhựa ABS cao cấp' , -- material - nvarchar(50)
          61 , -- weight - decimal(5, 1)
          N'Stickerless không viền' , -- color - nvarchar(50)
          N'Hệ thống tâm Maglev không dùng lò xo nhằm tăng độ bền và tính ổn định. Đây là bản cải tiến mới của Gan 11 M Pro, được trang bị bộ core nam châm vô cùng độc đáo.' , -- description - nvarchar(300)
          0  -- is_del - bit
        ),
		( 200000 , -- category_id - int
          400000 , -- manufacturer_id - int
          N' Gan 13 Maglev Fx Stickerless' , -- product_name - nvarchar(255)
          100 , -- quantity_in_stock - int
          988000 , -- original_price - decimal(16, 2)
          N'gan3x3-anh3.png' , -- image - nvarchar(250)
          N'56mm x 56mm x 56mm' , -- size - nvarchar(50)
          N'Nhựa ABS cao cấp' , -- material - nvarchar(50)
          65 , -- weight - decimal(5, 1)
          N'Stickerless không viền' , -- color - nvarchar(50)
          N'Core 3.0 với công nghệ tự động dễ dàng căn chỉnh các bước hơn ( có thể chỉnh 216 bước khác nhau )' , -- description - nvarchar(300)
          0  -- is_del - bit
        ),
		( 200000 , -- category_id - int
          400000 , -- manufacturer_id - int
          N' Gan 356 XS Stickerless/ Gan 356 XS Stickerless (Có Nam Châm)' , -- product_name - nvarchar(255)
          100 , -- quantity_in_stock - int
          689000 , -- original_price - decimal(16, 2)
          N'gan3x3-anh4.png' , -- image - nvarchar(250)
          N'56mm x 56mm x 56mm' , -- size - nvarchar(50)
          N'Nhựa ABS cao cấp' , -- material - nvarchar(50)
          68 , -- weight - decimal(5, 1)
          N'Stickerless không viền' , -- color - nvarchar(50)
          N'Rubik Gan 356 XS mang nhiều đặc tính nổi trội như tốc độ xoay cao hơn, trơn tru mượt mà hơn, không kẹt, không rít chống pop khi xoay ở tốc độ cao ( thích hợp finger trick look ahead ) cut góc và kiểm soát vòng xoay tốt' , -- description - nvarchar(300)
          0  -- is_del - bit
        ),
		( 200000 , -- category_id - int
          400000 , -- manufacturer_id - int
          N' Gan X Stickerless Version 2 phiên bản có nam châm' , -- product_name - nvarchar(255)
          100 , -- quantity_in_stock - int
          430000 , -- original_price - decimal(16, 2)
          N'gan3x3-anh5.png' , -- image - nvarchar(250)
          N'56mm x 56mm x 56mm' , -- size - nvarchar(50)
          N'Nhựa ABS cao cấp' , -- material - nvarchar(50)
          80 , -- weight - decimal(5, 1)
          N'Stickerless không viền' , -- color - nvarchar(50)
          N'Đã được hãng mod thêm nam châm để mang tới những trải nghiệm tốt nhất tri ân tới những khách hàng đã tin dùng sản phẩm trong suốt những năm tháng qua' , -- description - nvarchar(300)
          0  -- is_del - bit
        ),
		( 200000 , -- category_id - int
          400000 , -- manufacturer_id - int
          N'  Gan 11 M 2021 Có nam châm hãng Gan' , -- product_name - nvarchar(255)
          100 , -- quantity_in_stock - int
          459000 , -- original_price - decimal(16, 2)
          N'gan3x3-anh6.png' , -- image - nvarchar(250)
          N'56mm x 56mm x 56mm' , -- size - nvarchar(50)
          N'Nhựa ABS cao cấp' , -- material - nvarchar(50)
          56 , -- weight - decimal(5, 1)
          N'Stickerless không viền' , -- color - nvarchar(50)
          N'Với Hệ Thống Nam Châm Core mới tinh, cùng trọng lượng siêu nhẹ, Tốc độ cao - Trơn, mượt - Cắt góc tốt, Kiểm soát tốt - Chống pop, văng mảnh' , -- description - nvarchar(300)
          0  -- is_del - bit
        ),
		( 200000 , -- category_id - int
          400000 , -- manufacturer_id - int
          N'GAN 12 UI Free Play Smart Cube - Rubik 3x3 Kết Nối Bluetooth Kèm Quà Tặng ' , -- product_name - nvarchar(255)
          100 , -- quantity_in_stock - int
          2800000 , -- original_price - decimal(16, 2)
          N'gan3x3-anh7.png' , -- image - nvarchar(250)
          N'56mm x 56mm x 56mm' , -- size - nvarchar(50)
          N'Nhựa ABS cao cấp' , -- material - nvarchar(50)
          66.5 , -- weight - decimal(5, 1)
          N'Stickerless không viền' , -- color - nvarchar(50)
          N'1 Lần sạc đem tới 15h sử dụng. Tối ưu hóa cấu trúc bằng cách giảm kích thước lõi và tái cấu trúc trung tâm. GAN 12 UI đem tới một bước nhảy vọt về chất lượng về cảm giác, cắt góc và chống pop' , -- description - nvarchar(300)
          0  -- is_del - bit
        ),
		( 200000 , -- category_id - int
          400000 , -- manufacturer_id - int
          N' Gan Swift Block 2023 Stickerless Có Nam Châm' , -- product_name - nvarchar(255)
          100 , -- quantity_in_stock - int
          95000 , -- original_price - decimal(16, 2)
          N'gan3x3-anh8.png' , -- image - nvarchar(250)
          N'55mm x 55mm x 55mm' , -- size - nvarchar(50)
          N'Nhựa ABS cao cấp' , -- material - nvarchar(50)
          85 , -- weight - decimal(5, 1)
          N'Stickerless không viền' , -- color - nvarchar(50)
          N'Dòng rubik có nam châm với giá cả vô cùng hợp lý. Vấn đề rơi nam châm rất khó xảy ra với Gan Swift Block' , -- description - nvarchar(300)
          0  -- is_del - bit
        ),
		( 200000 , -- category_id - int
          400000 , -- manufacturer_id - int
          N'Rubik Tam Giác 3x3 - Rubik Kim Tự Tháp/ Gan Pyraminx' , -- product_name - nvarchar(255)
          100 , -- quantity_in_stock - int
          250000 , -- original_price - decimal(16, 2)
          N'gan3x3-anh9.png' , -- image - nvarchar(250)
          N'108mm x 104mm x 86mm' , -- size - nvarchar(50)
          N'Nhựa ABS cao cấp' , -- material - nvarchar(50)
          140.5 , -- weight - decimal(5, 1)
          N'Stickerless không viền' , -- color - nvarchar(50)
          N'Không có GES thay thế, 36 viên nam châm' , -- description - nvarchar(300)
          0  -- is_del - bit
        ),
		( 200000 , -- category_id - int
          400000 , -- manufacturer_id - int
          N' GAN Monster Go Cloud Blue' , -- product_name - nvarchar(255)
          100 , -- quantity_in_stock - int
          93000 , -- original_price - decimal(16, 2)
          N'gan3x3-anh10.png' , -- image - nvarchar(250)
          N'56mm x 56mm x 56mm' , -- size - nvarchar(50)
          N'Nhựa ABS cao cấp' , -- material - nvarchar(50)
          85 , -- weight - decimal(5, 1)
          N'Stickerless không viền, xanh dương' , -- color - nvarchar(50)
          N'  GAN Monster Go MG356 3x3 Cloud Blue là Rubik được dùng để dạy những người mới chơi rubik.' , -- description - nvarchar(300)
          0  -- is_del - bit
        ), -- 2X2X2
		( 200003 , -- category_id - int
          400000 , -- manufacturer_id - int
          N'GAN 251 M Leap Có Nam Châm Cao Cấp Hãng GAN CUBE' , -- product_name - nvarchar(255)
          100 , -- quantity_in_stock - int
          584000 , -- original_price - decimal(16, 2)
          N'gan2x2-anh1.png' , -- image - nvarchar(250)
          N'51mm x 51mm x 51mm' , -- size - nvarchar(50)
          N'Nhựa ABS cao cấp' , -- material - nvarchar(50)
          59 , -- weight - decimal(5, 1)
          N'Stickerless không viền' , -- color - nvarchar(50)
          N' Đây là chiếc rubik 2x2 được thừa hưởng thiết kế nam châm lõi của GAN 11 M Pro. Phiên bản này tối ưu hóa góc hút của nam châm, giúp layer tự vào vị trí trong khoảng ~30 độ.' , -- description - nvarchar(300)
          0  -- is_del - bit
        ),
		( 200003 , -- category_id - int
          400000 , -- manufacturer_id - int
          N'GAN 249 V2 M Stickerless (Có nam châm)' , -- product_name - nvarchar(255)
          100 , -- quantity_in_stock - int
          295000 , -- original_price - decimal(16, 2)
          N'gan2x2-anh2.png' , -- image - nvarchar(250)
          N'49mm x 49mm x 49mm' , -- size - nvarchar(50)
          N'Nhựa ABS cao cấp' , -- material - nvarchar(50)
          52 , -- weight - decimal(5, 1)
          N'Stickerless không viền' , -- color - nvarchar(50)
          N'Sản phẩm 2×2 cao cấp của GAN, đã mod sẵn nam châm và là 1 trong nhưng rubik 2x2x2 tốt nhất tại thời điểm hiện tại. Được các Pro Cuber thế giới đánh giá cao và sử dụng. Với Hệ Thống Nam Châm Core mới tinh, cùng trọng lượng siêu nhẹ' , -- description - nvarchar(300)
          0  -- is_del - bit
        ),
		( 200003 , -- category_id - int
          400000 , -- manufacturer_id - int
          N'GAN monster go Stickerless' , -- product_name - nvarchar(255)
          100 , -- quantity_in_stock - int
          150000 , -- original_price - decimal(16, 2)
          N'gan2x2-anh3.png' , -- image - nvarchar(250)
          N'51mm x 51mm x 51mm' , -- size - nvarchar(50)
          N'Nhựa ABS cao cấp' , -- material - nvarchar(50)
          57 , -- weight - decimal(5, 1)
          N'Stickerless không viền' , -- color - nvarchar(50)
          N' Rubik 2x2x2 GAN monster go Stickerless là 1 trong những khối rubik 2x2x2 tốt nhất cho người mới chơi. Thiết kế với cấu trúc mới giúp giải nhanh, giải tốc độ (thích hợp trong thi đấu).' , -- description - nvarchar(300)
          0  -- is_del - bit
        );
		GO 
	-- sản phẩm MOYU
INSERT INTO dbo.Product
        ( category_id ,manufacturer_id ,product_name ,quantity_in_stock ,original_price ,image ,size ,material ,weight ,color ,description ,is_del)
VALUES  --3x3x3
		( 200000 , -- category_id - int
          400001 , -- manufacturer_id - int
          N' MoYu WeiLong WRM Lite 2021' , -- product_name - nvarchar(255)
          100 , -- quantity_in_stock - int
          312000 , -- original_price - decimal(16, 2)
          N'moyu3x3-anh1.png' , -- image - nvarchar(250)
          N'55.5mm x 55.5mm x 55.5mm' , -- size - nvarchar(50)
          N'Nhựa ABS cao cấp' , -- material - nvarchar(50)
		  89 , -- weight - decimal(5, 1)
          N'Stickerless không viền' , -- color - nvarchar(50)
          N'Hệ thống Nam Châm là điểm khác biệt của WRM 2021, cho phép người dùng tùy ý điều chỉnh lực nam châm sao cho phù hợp với từng người. Được trang bị nhựa Primary cho toàn bộ phần thiết kế bên trong. WRM 2020 chỉ có nhựa Primary ở chân cạnh và chân góc.' , -- description - nvarchar(300)
          0  -- is_del - bit
        ),
		( 200000 , -- category_id - int
          400001 , -- manufacturer_id - int
          N' Moyu GTS 3M 3x3 Stickerless phiên bản từ tính mạnh' , -- product_name - nvarchar(255)
          100 , -- quantity_in_stock - int
          685000 , -- original_price - decimal(16, 2)
          N'moyu3x3-anh2.png' , -- image - nvarchar(250)
          N'56mm x 56mm x 56mm' , -- size - nvarchar(50)
          N'Nhựa ABS cao cấp' , -- material - nvarchar(50)
          92 , -- weight - decimal(5, 1)
          N'Stickerless không viền' , -- color - nvarchar(50)
          N'Phụ kiện đi kèm: hộp giấy, hộp nhựa đựng cube, bộ phụ kiện: nam châm, bộ chỉnh ốc, bộ chỉnh lò xo, 2 moyu card và giấy công thức.' , -- description - nvarchar(300)
          0  -- is_del - bit
        ),
		( 200000 , -- category_id - int
          400001 , -- manufacturer_id - int
          N' Moyu HuaMeng YS3M Hoa Mộng phiên bản Ballcore' , -- product_name - nvarchar(255)
          100 , -- quantity_in_stock - int
          258000 , -- original_price - decimal(16, 2)
          N'moyu3x3-anh3.png' , -- image - nvarchar(250)
          N'55 x55 x55 mm' , -- size - nvarchar(50)
          N'Nhựa ABS cao cấp' , -- material - nvarchar(50)
          83 , -- weight - decimal(5, 1)
          N'Stickerless không viền' , -- color - nvarchar(50)
          N'Đây là phiên bản lõi bi + đệm từ có khả năng từ hóa góc/lõi, hiệu chỉnh góc quay từ tính 25 độ (khả năng tự động điều hướng) và đại diện cho đỉnh cao của thiết kế MoYu 3x3.' , -- description - nvarchar(300)
          0  -- is_del - bit
        ),
		( 200000 , -- category_id - int
          400001 , -- manufacturer_id - int
          N' RS3M 2021 Maglev - Rubik Nam Châm Stickerless' , -- product_name - nvarchar(255)
          100 , -- quantity_in_stock - int
          208000 , -- original_price - decimal(16, 2)
          N'moyu3x3-anh4.png' , -- image - nvarchar(250)
          N'56mm x 56mm x 56mm' , -- size - nvarchar(50)
          N'Nhựa ABS cao cấp' , -- material - nvarchar(50)
          91 , -- weight - decimal(5, 1)
          N'Stickerless không viền' , -- color - nvarchar(50)
          N'RS3M 2021 là phiên bản tốt nhất trong phân khúc bình dân của MoYu, đã được mod maglev thay cho lò xo khắc phục điểm yếu tiếng ồn trên RS3M 2020 trước đó' , -- description - nvarchar(300)
          0  -- is_del - bit
        ),
		( 200000 , -- category_id - int
          400001 , -- manufacturer_id - int
          N' RS3M 2022 - Đồ Chơi Trí Tuệ - Khối Lập Phương 3 Tầng Stickerless ( Mod Nam Châm )' , -- product_name - nvarchar(255)
          100 , -- quantity_in_stock - int
          210000 , -- original_price - decimal(16, 2)
          N'moyu3x3-anh5.png' , -- image - nvarchar(250)
          N'56mm x 56mm x 56mm' , -- size - nvarchar(50)
          N'Nhựa ABS cao cấp' , -- material - nvarchar(50)
          122 , -- weight - decimal(5, 1)
          N'Stickerless không viền' , -- color - nvarchar(50)
          N'Phiên bản Maglev nam châm đã được nâng lên 60 viên, Xoay trơn và rất mượt, cắt góc tốt' , -- description - nvarchar(300)
          0  -- is_del - bit
        ),
		( 200000 , -- category_id - int
          400001 , -- manufacturer_id - int
          N'  2023 Moyu Weilong Wrm V9- Rubic 3 Tầng Weilong V9 3 Phiên Bản Magnetic' , -- product_name - nvarchar(255)
          100 , -- quantity_in_stock - int
          270000 , -- original_price - decimal(16, 2)
          N'moyu3x3-anh6.png' , -- image - nvarchar(250)
          N'55mm x 55mm x 55mm' , -- size - nvarchar(50)
          N'Nhựa ABS cao cấp' , -- material - nvarchar(50)
          67 , -- weight - decimal(5, 1)
          N'Stickerless không viền' , -- color - nvarchar(50)
          N'Tính năng cảm biến từ tính 3D: Nam châm hút kiểu 3 chiều (hiểu là khi xoay rubik đến 45 độ sẽ tự động hút vào cạnh). 9 Nấc điều chỉnh lực nam châm ở tâm và dễ dàng điều chỉnh' , -- description - nvarchar(300)
          0  -- is_del - bit
        ),
		( 200000 , -- category_id - int
          400001 , -- manufacturer_id - int
          N' Pyraminx Meilong Stickerless + Đế Qiyi Full màu' , -- product_name - nvarchar(255)
          100 , -- quantity_in_stock - int
          43800 , -- original_price - decimal(16, 2)
          N'moyu3x3-anh7.png' , -- image - nvarchar(250)
          N'72.0mm x 72.0mm x 72.0mm' , -- size - nvarchar(50)
          N'Nhựa ABS cao cấp' , -- material - nvarchar(50)
          65 , -- weight - decimal(5, 1)
          N'Stickerless không viền' , -- color - nvarchar(50)
          N'Thiết kế với cấu trúc mới giúp giải nhanh, giải tốc độ (thích hợp trong thi đấu). Tuy nhiên vẫn nên lube lại 1 chút để mang đến cảm giác chân thực nhất' , -- description - nvarchar(300)
          0  -- is_del - bit
        ),
		( 200000 , -- category_id - int
          400001 , -- manufacturer_id - int
          N'WRM 2021 Bản Full + Lube Rubik ( Moyu V1, V2, Mystic, Silk )' , -- product_name - nvarchar(255)
          100 , -- quantity_in_stock - int
          650000 , -- original_price - decimal(16, 2)
          N'moyu3x3-anh8.png' , -- image - nvarchar(250)
          N'55mm x 55mm x 55mm' , -- size - nvarchar(50)
          N'Nhựa ABS cao cấp' , -- material - nvarchar(50)
          85 , -- weight - decimal(5, 1)
          N'Stickerless không viền' , -- color - nvarchar(50)
          N'Hệ thống Nam Châm là điểm khác biệt của WRM 2021, cho phép người dùng tùy ý điều chỉnh lực nam châm sao cho phù hợp với từng người. Những chai lube giúp tăng tốc độ giải rubik và mang lại trải nghiệm tuyệt vời nhất cho người chơi' , -- description - nvarchar(300)
          0  -- is_del - bit
        ),    -- 2X2X2 ***
		( 200003 , -- category_id - int
          400001 , -- manufacturer_id - int
          N'RS2M - Đồ Chơi Trí Tuệ - Moyu - 2 Tầng Stickerless ( Hãng Mod Nam Châm )' , -- product_name - nvarchar(255)
          100 , -- quantity_in_stock - int
          125000 , -- original_price - decimal(16, 2)
          N'moyu2x2-anh1.png' , -- image - nvarchar(250)
          N'50mm x 50mm x 50mm' , -- size - nvarchar(50)
          N'Nhựa ABS cao cấp' , -- material - nvarchar(50)
          85 , -- weight - decimal(5, 1)
          N'Stickerless không viền' , -- color - nvarchar(50)
          N'Thiết kế với cấu trúc mới giúp giải nhanh, giải tốc độ (thích hợp trong thi đấu). Rubik xoay trơn, không kẹt, không rít. Độ bền cao, tính ổn định tốt mà giá cả lại rất yêu thương' , -- description - nvarchar(300)
          0  -- is_del - bit
        ),
		( 200003 , -- category_id - int
          400001 , -- manufacturer_id - int
          N' MoYu MeiLong 2M M Series MoYu M MeiLong M Rubic 2 Tầng Nam Châm' , -- product_name - nvarchar(255)
          100 , -- quantity_in_stock - int
          90000 , -- original_price - decimal(16, 2)
          N'moyu2x2-anh2.png' , -- image - nvarchar(250)
          N'50mm x 50mm x 50mm' , -- size - nvarchar(50)
          N'Nhựa ABS cao cấp' , -- material - nvarchar(50)
          85 , -- weight - decimal(5, 1)
          N'Stickerless không viền' , -- color - nvarchar(50)
          N' Siêu phẩm cube dòng bình dân của hãng MoYu năm 2020. Bản cải tiến mới của 2x2, được trang bị nam châm giúp kiểm soát tốt hơn, chơi phê hơn.' , -- description - nvarchar(300)
          0  -- is_del - bit
        ), 
		( 200003 , -- category_id - int
          400001 , -- manufacturer_id - int
          N'Stickerless MoYu MeiLong MFJS ' , -- product_name - nvarchar(255)
          100 , -- quantity_in_stock - int
          30000 , -- original_price - decimal(16, 2)
          N'moyu2x2-anh3.png' , -- image - nvarchar(250)
          N'50mm x 50mm x 50mm' , -- size - nvarchar(50)
          N'Nhựa ABS cao cấp' , -- material - nvarchar(50)
          69 , -- weight - decimal(5, 1)
          N'Stickerless không viền' , -- color - nvarchar(50)
          N' Rubik 2x2 Stickerless MoYu MeiLong MFJS Rubic 2 Tầng 2x2x2. Thiết kế với cấu trúc mới giúp giải nhanh, giải tốc độ (thích hợp trong thi đấu).' , -- description - nvarchar(300)
          0  -- is_del - bit
        ), -- 4x4x4 ****
		( 200001 , -- category_id - int
          400001 , -- manufacturer_id - int
          N' MoYu MeiLong 4M M Series MoYu M MeiLong M (Nam Châm)' , -- product_name - nvarchar(255)
          100 , -- quantity_in_stock - int
          160000 , -- original_price - decimal(16, 2)
          N'moyu4x4-anh1.png' , -- image - nvarchar(250)
          N'59mm x 59mm x 59mm' , -- size - nvarchar(50)
          N'Nhựa ABS cao cấp' , -- material - nvarchar(50)
          132.1 , -- weight - decimal(5, 1)
          N'Stickerless không viền' , -- color - nvarchar(50)
          N'Siêu phẩm cube dòng bình dân của hãng MoYu năm 2020. Bản cải tiến mới của 4x4, được trang bị nam châm giúp kiểm soát tốt hơn, chơi phê hơn.' , -- description - nvarchar(300)
          0   -- is_del - bit
        ),
		( 200001 , -- category_id - int
          400001 , -- manufacturer_id - int
          N' RS4M MFJS - Rubik Nam Châm Stickerless' , -- product_name - nvarchar(255)
          100 , -- quantity_in_stock - int
          250000 , -- original_price - decimal(16, 2)
          N'moyu4x4-anh2.png' , -- image - nvarchar(250)
          N'61mm x 61mm x 61mm' , -- size - nvarchar(50)
          N'Nhựa ABS cao cấp' , -- material - nvarchar(50)
          176 , -- weight - decimal(5, 1)
          N'Stickerless không viền' , -- color - nvarchar(50)
          N'Thiết kế với cấu trúc mới giúp giải nhanh, giải tốc độ (thích hợp trong thi đấu). RS4 M 2020 kế thừa và cải thiện độ ngon từ cube RS3 M 2020 huyền thoại.' , -- description - nvarchar(300)
          0  -- is_del - bit
        ),
		( 200001 , -- category_id - int
          400001 , -- manufacturer_id - int
          N' Stickerless MoYu MeiLong MFJS Rubic 4 Tầng 4x4x4' , -- product_name - nvarchar(255)
          100 , -- quantity_in_stock - int
          60000 , -- original_price - decimal(16, 2)
          N'moyu4x4-anh3.png' , -- image - nvarchar(250)
          N'59mm x 59mm x 59mm' , -- size - nvarchar(50)
          N'Nhựa ABS cao cấp' , -- material - nvarchar(50)
          114 , -- weight - decimal(5, 1)
          N'Stickerless không viền' , -- color - nvarchar(50)
          N'Thiết kế với cấu trúc mới giúp giải nhanh, giải tốc độ (thích hợp trong thi đấu). Rubik xoay trơn, không kẹt, không rít. Độ bền cao, tính ổn định tốt mà giá cả lại rất yêu thương' , -- description - nvarchar(300)
          0  -- is_del - bit
        ),
		( 200001 , -- category_id - int
          400001 , -- manufacturer_id - int
          N'Rubik Carbon 4x4 - MoYu MeiLong - Rubik 4 Tầng Meilong Carbon' , -- product_name - nvarchar(255)
          100 , -- quantity_in_stock - int
          113000 , -- original_price - decimal(16, 2)
          N'moyu4x4-anh4.png' , -- image - nvarchar(250)
          N'58mm x 58mm x 58mm' , -- size - nvarchar(50)
          N'Nhựa ABS cao cấp' , -- material - nvarchar(50)
          116 , -- weight - decimal(5, 1)
          N'Carbon' , -- color - nvarchar(50)
          N'Thiết kế với cấu trúc mới giúp giải nhanh, giải tốc độ (thích hợp trong thi đấu). Tuy nhiên vẫn nên lube lại 1 chút để mang đến cảm giác chân thực nhất.' , -- description - nvarchar(300)
          0  -- is_del - bit
        ), --5x5x5 ****
		( 200002 , -- category_id - int
          400001 , -- manufacturer_id - int
          N'MoYu MeiLong 5M - Rubic 5 Tầng Nam Châm Stickerless' , -- product_name - nvarchar(255)
          100 , -- quantity_in_stock - int
          190000 , -- original_price - decimal(16, 2)
          N'moyu5x5-anh1.png' , -- image - nvarchar(250)
          N'60mm x 60mm x 60mm' , -- size - nvarchar(50)
          N'Nhựa ABS cao cấp' , -- material - nvarchar(50)
          131.5 , -- weight - decimal(5, 1)
          N'Stickerless không viền' , -- color - nvarchar(50)
          N'Siêu phẩm cube dòng bình dân của hãng MoYu năm 2020. Bản cải tiến mới của 5x5, được trang bị nam châm giúp kiểm soát tốt hơn, chơi phê hơn.' , -- description - nvarchar(300)
          0  -- is_del - bit
        ),
		( 200002 , -- category_id - int
          400001 , -- manufacturer_id - int
          N'Moyu WRM Aochuang Stickerless' , -- product_name - nvarchar(255)
          100 , -- quantity_in_stock - int
          700000 , -- original_price - decimal(16, 2)
          N'moyu5x5-anh2.png' , -- image - nvarchar(250)
          N'61.5mm x 61.5mm x 61.5mm' , -- size - nvarchar(50)
          N'Nhựa ABS cao cấp' , -- material - nvarchar(50)
          134 , -- weight - decimal(5, 1)
          N'Stickerless không viền' , -- color - nvarchar(50)
          N'Khối 5x5 trong dòng "record-breaking" cao cấp của Moyu. Tốc độ cube cực kì nhanh ngay khi vừa mở hộp. Cảm giác xoay mượt, êm và khá giống khối 4x4 Aosu WRM cùng dòng' , -- description - nvarchar(300)
          0  -- is_del - bit
        ),
		( 200002 , -- category_id - int
          400001 , -- manufacturer_id - int
          N'Meilong 5' , -- product_name - nvarchar(255)
          100 , -- quantity_in_stock - int
          108000 , -- original_price - decimal(16, 2)
          N'moyu5x5-anh3.png' , -- image - nvarchar(250)
          N'58mm x 58mm x 58mm' , -- size - nvarchar(50)
          N'Nhựa ABS cao cấp' , -- material - nvarchar(50)
          114 , -- weight - decimal(5, 1)
          N'Stickerless không viền' , -- color - nvarchar(50)
          N'Siêu phẩm cube dòng bình dân của hãng MoYu năm 2020. Thiết kế với cấu trúc mới giúp giải nhanh, giải tốc độ (thích hợp trong thi đấu).' , -- description - nvarchar(300)
          0  -- is_del - bit
        )

		-- sản phẩm QIYI
INSERT INTO dbo.Product
        ( category_id ,
          manufacturer_id ,
          product_name ,
          quantity_in_stock ,
          original_price ,
          image ,
          size ,
          material ,
          weight ,
          color ,
          description ,
          is_del
        ) -- 3x3x ***
VALUES  ( 200000 , -- category_id - int
          400002 , -- manufacturer_id - int
          N' - Tornado V3 M 3 Phiên bản Standard' , -- product_name - nvarchar(255)
          100 , -- quantity_in_stock - int
          500000 , -- original_price - decimal(16, 2)
          N'qiyi3x3-anh1.png' , -- image - nvarchar(250)
          N'55.5mm x 55.5mm x 55.5mm' , -- size - nvarchar(50)
          N'Nhựa Primary' , -- material - nvarchar(50)
          69 , -- weight - decimal(5, 1)
          N'Stickerless' , -- color - nvarchar(50)
          N'Phiên bản stand được nâng cấp chút ít so với người tiền nhiệm tornado V2M' , -- description - nvarchar(300)
          0  -- is_del - bit
        ),
		( 200000 , -- category_id - int
          400002 , -- manufacturer_id - int
          N'Combo Qiyi Sail W + Đế QiYi DNA ( Full màu )' , -- product_name - nvarchar(255)
          100 , -- quantity_in_stock - int
          30000 , -- original_price - decimal(16, 2)
          N'qiyi3x3-anh2.png' , -- image - nvarchar(250)
          N' 56mm x 56mm x 56mm' , -- size - nvarchar(50)
          N'Nhựa ABS cao cấp' , -- material - nvarchar(50)
          79 , -- weight - decimal(5, 1)
          N'Sticker' , -- color - nvarchar(50)
          N'Thiết kế với cấu trúc mới giúp giải nhanh, giải tốc độ (thích hợp trong thi đấu). Tuy nhiên vẫn nên lube lại 1 chút để mang đến cảm giác chân thực nhất' , -- description - nvarchar(300)
          0  -- is_del - bit
        ),
		( 200000 , -- category_id - int
          400002 , -- manufacturer_id - int
          N' Qiyi M Pro 2023 Stickerless- Rubic 3x3 Qiyi M Pro Có Nam Châm 2 Phiên Bản Hộp Nhựa/ Hộp Giấy' , -- product_name - nvarchar(255)
          100 , -- quantity_in_stock - int
          120000 , -- original_price - decimal(16, 2)
          N'qiyi3x3-anh3.png' , -- image - nvarchar(250)
          N' 55mm x 55mm x 55mm' , -- size - nvarchar(50)
          N'Nhựa ABS cao cấp' , -- material - nvarchar(50)
          79 , -- weight - decimal(5, 1)
          N'Stickerless' , -- color - nvarchar(50)
          N' Thiết kế với cấu trúc mới giúp giải nhanh, giải tốc độ (thích hợp trong thi đấu). Rubik xoay trơn, không kẹt, không rít.' , -- description - nvarchar(300)
          0  -- is_del - bit
        ),
		( 200000 , -- category_id - int
          400002 , -- manufacturer_id - int
          N' QiYi Qimeng Plus 9cm 2020 ' , -- product_name - nvarchar(255)
          100 , -- quantity_in_stock - int
          90000 , -- original_price - decimal(16, 2)
          N'qiyi3x3-anh4.png' , -- image - nvarchar(250)
          N'90mm x 90mm x 90mm' , -- size - nvarchar(50)
          N'Nhựa ABS cao cấp' , -- material - nvarchar(50)
          180 , -- weight - decimal(5, 1)
          N'Stickerless' , -- color - nvarchar(50)
          N'Thiết kế với cấu trúc mới, kích thước to. Rubik xoay trơn, không kẹt, không rít.' , -- description - nvarchar(300)
          0  -- is_del - bit
        ),
		( 200000 , -- category_id - int
          400002 , -- manufacturer_id - int
          N'QiYi MS Magnetic 2020 stickerless (Có nam Châm- Hãng Mod M)' , -- product_name - nvarchar(255)
          100 , -- quantity_in_stock - int
          99000 , -- original_price - decimal(16, 2)
          N'qiyi3x3-anh5.png' , -- image - nvarchar(250)
          N'56mm x 56mm x 56mm' , -- size - nvarchar(50)
          N'Nhựa ABS cao cấp' , -- material - nvarchar(50)
          81.8 , -- weight - decimal(5, 1)
          N'Stickerless' , -- color - nvarchar(50)
          N'Thiết kế với cấu trúc mới giúp giải nhanh, giải tốc độ (thích hợp trong thi đấu). Tuy nhiên vẫn nên lube lại 1 chút để mang đến cảm giác chân thực nhất' , -- description - nvarchar(300)
          0  -- is_del - bit
        ),
		( 200000 , -- category_id - int
          400002 , -- manufacturer_id - int
          N' XMan Tornado V2 M 2021/ Tornado V2M Stickerless Phiên Bản Thứ 2 ( Có Nam Châm )' , -- product_name - nvarchar(255)
          100 , -- quantity_in_stock - int
          520000 , -- original_price - decimal(16, 2)
          N'qiyi3x3-anh6.png' , -- image - nvarchar(250)
          N'55.0mm x 55.0mm x 55.0mm.' , -- size - nvarchar(50)
          N'Nhựa ABS cao cấp' , -- material - nvarchar(50)
          72 , -- weight - decimal(5, 1)
          N'Stickerless' , -- color - nvarchar(50)
          N'QiYi X-Man Tornado V2 là chiếc rubik 3x3 flagship mới nhất của QiYi năm 2021. Được nhà sản xuất hiệu chỉnh các chi tiết áp lực, lực xoay ở mức tốt nhất' , -- description - nvarchar(300)
          0  -- is_del - bit
        ),
		( 200000 , -- category_id - int
          400002 , -- manufacturer_id - int
          N'Rubik pyraminx 3x3 QiYi MS Magnetic 2020 stickerless (Có nam Châm- Hãng Mod M)' , -- product_name - nvarchar(255)
          100 , -- quantity_in_stock - int
          111121 , -- original_price - decimal(16, 2)
          N'qiyi3x3-anh7.png' , -- image - nvarchar(250)
          N'78.0mm x 78.0mm x 78.0mm' , -- size - nvarchar(50)
          N'Nhựa ABS cao cấp' , -- material - nvarchar(50)
          78.5 , -- weight - decimal(5, 1)
          N'Stickerless' , -- color - nvarchar(50)
          N'Thiết kế với cấu trúc mới giúp giải nhanh, giải tốc độ (thích hợp trong thi đấu). Tuy nhiên vẫn nên lube lại 1 chút để mang đến cảm giác chân thực nhất' , -- description - nvarchar(300)
          0  -- is_del - bit
        ), --2x2 **
		( 200003 , -- category_id - int
          400002 , -- manufacturer_id - int
          N' QiYi MS Magnetic 2020 stickerless (Có nam Châm- Hãng Mod M)' , -- product_name - nvarchar(255)
          100 , -- quantity_in_stock - int
          94117 , -- original_price - decimal(16, 2)
          N'qiyi2x2-anh1.png' , -- image - nvarchar(250)
          N'51.0mm x 51.0mm x 51.0mm' , -- size - nvarchar(50)
          N'Nhựa ABS cao cấp' , -- material - nvarchar(50)
          58.7 , -- weight - decimal(5, 1)
          N'Stickerless' , -- color - nvarchar(50)
          N'Thiết kế với cấu trúc mới giúp giải nhanh, giải tốc độ (thích hợp trong thi đấu). Tuy nhiên vẫn nên lube lại 1 chút để mang đến cảm giác chân thực nhất' , -- description - nvarchar(300)
          0  -- is_del - bit
        ),
		( 200003 , -- category_id - int
          400002 , -- manufacturer_id - int
          N' QiYi QiDi W Black ( Viền Đen )' , -- product_name - nvarchar(255)
          100 , -- quantity_in_stock - int
          38800 , -- original_price - decimal(16, 2)
          N'qiyi2x2-anh2.png' , -- image - nvarchar(250)
          N'50mm x 50mm x 50mm' , -- size - nvarchar(50)
          N'Nhựa ABS cao cấp' , -- material - nvarchar(50)
          55 , -- weight - decimal(5, 1)
          N'Sticker' , -- color - nvarchar(50)
          N'Thiết kế với cấu trúc mới giúp giải nhanh, giải tốc độ (thích hợp trong thi đấu). Tuy nhiên vẫn nên lube lại 1 chút để mang đến cảm giác chân thực nhất' , -- description - nvarchar(300)
          0  -- is_del - bit
        ),
		( 200003 , -- category_id - int
          400002 , -- manufacturer_id - int
          N'X Man Flare - Đồ Chơi Trí Tuệ Khối Lập Phương 2 Tầng X Man Flare QiYi ( Có Nam Châm )' , -- product_name - nvarchar(255)
          100 , -- quantity_in_stock - int
          389000 , -- original_price - decimal(16, 2)
          N'qiyi2x2-anh3.png' , -- image - nvarchar(250)
          N'51mm x 51mm x 51mm' , -- size - nvarchar(50)
          N'Nhựa ABS cao cấp' , -- material - nvarchar(50)
          65.2 , -- weight - decimal(5, 1)
          N'Stickerless' , -- color - nvarchar(50)
          N'Đây là dòng Rubik 2x2 hạng sang được x man designs và có sẵn nam châm. Thiết kế với cấu trúc mới giúp giải nhanh, giải tốc độ (thích hợp trong thi đấu).' , -- description - nvarchar(300)
          0  -- is_del - bit
        ), --4x4 ****
		( 200001 , -- category_id - int
          400002 , -- manufacturer_id - int
          N' QiYi MS 2020 stickerless Không Viền (Có nam Châm- Hãng Mod M)' , -- product_name - nvarchar(255)
          100 , -- quantity_in_stock - int
          195581 , -- original_price - decimal(16, 2)
          N'qiyi4x4-anh1.png' , -- image - nvarchar(250)
          N'62.0mm x 62.0mm x 62.0mm' , -- size - nvarchar(50)
          N'Nhựa ABS cao cấp' , -- material - nvarchar(50)
          135.6 , -- weight - decimal(5, 1)
          N'Stickerless' , -- color - nvarchar(50)
          N'Thiết kế với cấu trúc mới giúp giải nhanh, giải tốc độ (thích hợp trong thi đấu). Tuy nhiên vẫn nên lube lại 1 chút để mang đến cảm giác chân thực nhất' , -- description - nvarchar(300)
          0  -- is_del - bit
        ),
		( 200001 , -- category_id - int
          400002 , -- manufacturer_id - int
          N' QiYi Qiyuan W2 Black ( Màu Đen )' , -- product_name - nvarchar(255)
          100 , -- quantity_in_stock - int
          90500 , -- original_price - decimal(16, 2)
          N'qiyi4x4-anh2.png' , -- image - nvarchar(250)
          N'59mm x 59mm x 59mm' , -- size - nvarchar(50)
          N'Nhựa ABS cao cấp' , -- material - nvarchar(50)
          114 , -- weight - decimal(5, 1)
          N'Sticker' , -- color - nvarchar(50)
          N'Thiết kế với cấu trúc mới giúp giải nhanh, giải tốc độ (thích hợp trong thi đấu). Tuy nhiên vẫn nên lube lại 1 chút để mang đến cảm giác chân thực nhất' , -- description - nvarchar(300)
          0  -- is_del - bit
        ),
		( 200001 , -- category_id - int
          400002 , -- manufacturer_id - int
          N' QiYi Xman Ambition Flagship ( Hãng Mod Nam Châm )' , -- product_name - nvarchar(255)
          100 , -- quantity_in_stock - int
          688000 , -- original_price - decimal(16, 2)
          N'qiyi4x4-anh3.png' , -- image - nvarchar(250)
          N'60.0mm x 60.0mm x 60.0mm' , -- size - nvarchar(50)
          N'Nhựa ABS cao cấp' , -- material - nvarchar(50)
          106 , -- weight - decimal(5, 1)
          N'Stickerless' , -- color - nvarchar(50)
          N'Thiết kế với cấu trúc mới giúp giải nhanh, giải tốc độ (thích hợp trong thi đấu). Bản cải tiến mới của 4x4, được trang bị thêm nam châm' , -- description - nvarchar(300)
          0  -- is_del - bit
        ), -- 5x5 ****
		( 200002 , -- category_id - int
          400002 , -- manufacturer_id - int
          N' QiYi Qizheng Black (Màu Đen)' , -- product_name - nvarchar(255)
          100 , -- quantity_in_stock - int
          123000 , -- original_price - decimal(16, 2)
          N'qiyi5x5-anh1.png' , -- image - nvarchar(250)
          N'62mm x 62mm x 62mm' , -- size - nvarchar(50)
          N'Nhựa ABS cao cấp' , -- material - nvarchar(50)
          156.3 , -- weight - decimal(5, 1)
          N'Sticker' , -- color - nvarchar(50)
          N'Siêu phẩm cube dòng bình dân của hãng QiYi. Thiết kế với cấu trúc mới giúp giải nhanh, giải tốc độ (thích hợp trong thi đấu)' , -- description - nvarchar(300)
          0  -- is_del - bit
        ),
		( 200002 , -- category_id - int
          400002 , -- manufacturer_id - int
          N'Rubik Qiyi MS 5x5 - Khối Lập Phương 5 Tầng Có Nam Châm ( Hãng Mod )' , -- product_name - nvarchar(255)
          100 , -- quantity_in_stock - int
          305000 , -- original_price - decimal(16, 2)
          N'qiyi5x5-anh2.png' , -- image - nvarchar(250)
          N'63mm x 63mm x 63mm' , -- size - nvarchar(50)
          N'Nhựa ABS cao cấp' , -- material - nvarchar(50)
          163 , -- weight - decimal(5, 1)
          N'Stickerless' , -- color - nvarchar(50)
          N'Siêu phẩm cube dòng bình dân của hãng QiYi. Thiết kế với cấu trúc mới giúp giải nhanh, giải tốc độ (thích hợp trong thi đấu)' , -- description - nvarchar(300)
          0  -- is_del - bit
        );


		-- hãng DAYAN

INSERT INTO dbo.Product
        ( category_id ,
          manufacturer_id ,
          product_name ,
          quantity_in_stock ,
          original_price ,
          image ,
          size ,
          material ,
          weight ,
          color ,
          description ,
          is_del
        ) --3x3 ***
VALUES  ( 200000 , -- category_id - int
          400003 , -- manufacturer_id - int
          N' Dayan Guhong V4 M phiên bản CHÍNH HÃNG mod Nam châm' , -- product_name - nvarchar(255)
          100 , -- quantity_in_stock - int
          228000 , -- original_price - decimal(16, 2)
          N'dayan3x3-anh1.png' , -- image - nvarchar(250)
          N'56mm x 56mm x 56mm' , -- size - nvarchar(50)
          N'Nhựa ABS cao cấp' , -- material - nvarchar(50)
          65.5 , -- weight - decimal(5, 1)
          N'Stickerless' , -- color - nvarchar(50)
          N'Sau 1 thời gian dài đợi chờ thì cuối cùng hãng DaYan đã ra mắt phiên bản cải tiến mới nhất của dòng Guhong vốn đã từng rất thành công trước đó' , -- description - nvarchar(300)
          0  -- is_del - bit
        ),
		( 200000 , -- category_id - int
          400003 , -- manufacturer_id - int
          N' DaYan TengYun - Đồ Chơi Rubic 3 Tầng Có Nam Châm Stickerless Không Viền' , -- product_name - nvarchar(255)
          100 , -- quantity_in_stock - int
          580000 , -- original_price - decimal(16, 2)
          N'dayan3x3-anh2.png' , -- image - nvarchar(250)
          N'55.5mm x 55.5mm x 55.5mm' , -- size - nvarchar(50)
          N'Nhựa ABS cao cấp' , -- material - nvarchar(50)
          83 , -- weight - decimal(5, 1)
          N'Stickerless' , -- color - nvarchar(50)
          N'Thiết kế với cấu trúc mới giúp giải nhanh, giải tốc độ (thích hợp trong thi đấu). Tuy nhiên vẫn nên lube lại 1 chút để mang đến cảm giác chân thực nhất' , -- description - nvarchar(300)
          0  -- is_del - bit
        ),
		( 200000 , -- category_id - int
          400003 , -- manufacturer_id - int
          N' DaYan ZhanChi Pro M' , -- product_name - nvarchar(255)
          100 , -- quantity_in_stock - int
          687000 , -- original_price - decimal(16, 2)
          N'dayan3x3-anh3.png' , -- image - nvarchar(250)
          N'56mm x 56mm x 56mm' , -- size - nvarchar(50)
          N'Nhựa ABS cao cấp' , -- material - nvarchar(50)
          77 , -- weight - decimal(5, 1)
          N'Stickerless' , -- color - nvarchar(50)
          N'Thiết kế với cấu trúc mới giúp giải nhanh, giải tốc độ (thích hợp trong thi đấu). Tuy nhiên vẫn nên lube lại 1 chút để mang đến cảm giác chân thực nhất' , -- description - nvarchar(300)
          0  -- is_del - bit
        ),
		( 200000 , -- category_id - int
          400003 , -- manufacturer_id - int
          N' Diansheng M Stickerless 2021 (Có Nam Châm)' , -- product_name - nvarchar(255)
          100 , -- quantity_in_stock - int
          138000 , -- original_price - decimal(16, 2)
          N'dayan3x3-anh4.png' , -- image - nvarchar(250)
          N'55.5mm x 55.5mm x 55.5mm' , -- size - nvarchar(50)
          N'Nhựa ABS cao cấp' , -- material - nvarchar(50)
          68 , -- weight - decimal(5, 1)
          N'Stickerless' , -- color - nvarchar(50)
          N'Diansheng M Stickerless (có Nam Châm) 2021 là rubik có nam châm cho người mới chơi với ưu điểm: siêu nhẹ (68g), nhanh với lực hút nam châm ở mức vừa/mạnh' , -- description - nvarchar(300)
          0  -- is_del - bit
        ), --2x2****
		( 200003 , -- category_id - int
          400003 , -- manufacturer_id - int
          N' Dayan TengYun' , -- product_name - nvarchar(255)
          100 , -- quantity_in_stock - int
          370000 , -- original_price - decimal(16, 2)
          N'dayan2x2-anh1.png' , -- image - nvarchar(250)
          N'50mm x 50mm x 50mm' , -- size - nvarchar(50)
          N'Nhựa ABS cao cấp' , -- material - nvarchar(50)
          62 , -- weight - decimal(5, 1)
          N'Stickerless' , -- color - nvarchar(50)
          N'Thiết kế với cấu trúc mới giúp giải nhanh, giải tốc độ (thích hợp trong thi đấu). Tuy nhiên vẫn nên lube lại 1 chút để mang đến cảm giác chân thực nhất' , -- description - nvarchar(300)
          0  -- is_del - bit
        );

		--hãng YONGJUN

INSERT INTO dbo.Product
        ( category_id ,
          manufacturer_id ,
          product_name ,
          quantity_in_stock ,
          original_price ,
          image ,
          size ,
          material ,
          weight ,
          color ,
          description ,
          is_del
        ) --3x3 ***
VALUES  ( 200000 , -- category_id - int
          400004 , -- manufacturer_id - int
          N' MGC Elite - Đồ Chơi Rubik 3 Tầng Stickerless ( Có Nam Châm )' , -- product_name - nvarchar(255)
          100 , -- quantity_in_stock - int
          472000 , -- original_price - decimal(16, 2)
          N'yongjun3x3-anh1.png' , -- image - nvarchar(250)
          N'55.5mm x 55.5mm x 55.5mm' , -- size - nvarchar(50)
          N'Nhựa ABS cao cấp' , -- material - nvarchar(50)
          87 , -- weight - decimal(5, 1)
          N'Stickerless ' , -- color - nvarchar(50)
          N'MGC3 Elite 3x3 M (Có nam châm sẵn) được sản xuất bởi hãng YongJun YJ. Mang trong mình những thiết kế mới nhất, MGC Elite sở hữu có hệ thống nam châm và lò xo có thể chỉnh được theo từng mức độ khác nhau.' , -- description - nvarchar(300)
          0  -- is_del - bit
        ),
		( 200000 , -- category_id - int
          400004 , -- manufacturer_id - int
          N' YJ Pyraminx - Rubic Tam Giác 3 Tầng Stickerless Không Viền Có Nam Châm' , -- product_name - nvarchar(255)
          100 , -- quantity_in_stock - int
          157000 , -- original_price - decimal(16, 2)
          N'yongjun3x3-anh2.png' , -- image - nvarchar(250)
          N'86mm x 86mm x 86mm' , -- size - nvarchar(50)
          N'Nhựa ABS cao cấp' , -- material - nvarchar(50)
          97 , -- weight - decimal(5, 1)
          N'Stickerless ' , -- color - nvarchar(50)
          N'Thiết kế với cấu trúc mới giúp giải nhanh, giải tốc độ (thích hợp trong thi đấu). Tuy nhiên vẫn nên lube lại 1 chút để mang đến cảm giác chân thực nhất' , -- description - nvarchar(300)
          0  -- is_del - bit
        ),
		( 200000 , -- category_id - int
          400004 , -- manufacturer_id - int
          N' YJ YuLong V2 M Stickerless ( Có Nam Châm )' , -- product_name - nvarchar(255)
          100 , -- quantity_in_stock - int
          175000 , -- original_price - decimal(16, 2)
          N'yongjun3x3-anh3.png' , -- image - nvarchar(250)
          N'57mm x 57mm x 57mm' , -- size - nvarchar(50)
          N'Nhựa ABS cao cấp' , -- material - nvarchar(50)
          103 , -- weight - decimal(5, 1)
          N'Stickerless ' , -- color - nvarchar(50)
          N'Thiết kế với cấu trúc mới giúp giải nhanh, giải tốc độ (thích hợp trong thi đấu). Tuy nhiên vẫn nên lube lại 1 chút để mang đến cảm giác chân thực nhất' , -- description - nvarchar(300)
          0  -- is_del - bit
        ),
		( 200000 , -- category_id - int
          400004 , -- manufacturer_id - int
          N'YongJun MGC 3x3 Có Nam Châm- YJ MGC 3 V2 M Stickerless' , -- product_name - nvarchar(255)
          100 , -- quantity_in_stock - int
          327000 , -- original_price - decimal(16, 2)
          N'yongjun3x3-anh4.png' , -- image - nvarchar(250)
          N'50mm x 50mm x 50mm' , -- size - nvarchar(50)
          N'Nhựa ABS cao cấp' , -- material - nvarchar(50)
          66.7 , -- weight - decimal(5, 1)
          N'Stickerless ' , -- color - nvarchar(50)
          N'Thiết kế với cấu trúc mới giúp giải nhanh, giải tốc độ (thích hợp trong thi đấu). Tuy nhiên vẫn nên lube lại 1 chút để mang đến cảm giác chân thực nhất' , -- description - nvarchar(300)
          0  -- is_del - bit
        ),
		( 200000 , -- category_id - int
          400004 , -- manufacturer_id - int
          N'Siêu Phẩm YongJun MGC Evo 2023 Stickerless Có Nam Châm Cao Cấp' , -- product_name - nvarchar(255)
          100 , -- quantity_in_stock - int
          450000 , -- original_price - decimal(16, 2)
          N'yongjun3x3-anh5.png' , -- image - nvarchar(250)
          N'61mm x 61mm x 61mm' , -- size - nvarchar(50)
          N'Nhựa ABS cao cấp' , -- material - nvarchar(50)
          115 , -- weight - decimal(5, 1)
          N'Stickerless ' , -- color - nvarchar(50)
          N'Thiết kế với cấu trúc mới giúp giải nhanh, giải tốc độ (thích hợp trong thi đấu). Tuy nhiên vẫn nên lube lại 1 chút để mang đến cảm giác chân thực nhất' , -- description - nvarchar(300)
          0  -- is_del - bit
        ), --2x2**
		( 200003 , -- category_id - int
          400004 , -- manufacturer_id - int
          N' MGC Elite - Có Nam Châm Stickerless Không Viền' , -- product_name - nvarchar(255)
          100 , -- quantity_in_stock - int
          349000 , -- original_price - decimal(16, 2)
          N'yongjun2x2-anh1.png' , -- image - nvarchar(250)
          N'51mm x 51mm x 51mm' , -- size - nvarchar(50)
          N'Nhựa ABS cao cấp' , -- material - nvarchar(50)
          71 , -- weight - decimal(5, 1)
          N'Stickerless ' , -- color - nvarchar(50)
          N'Đây là  đầu tiên trên thế giới có nam châm ở phần tâm (thay vì ở góc như các sản phẩm truyền thống).' , -- description - nvarchar(300)
          0  -- is_del - bit
        ),
		( 200003 , -- category_id - int
          400004 , -- manufacturer_id - int
          N' YJ MGC - Đồ Chơi Rubik 2 Tầng MGC YJ 2x2' , -- product_name - nvarchar(255)
          100 , -- quantity_in_stock - int
          250000 , -- original_price - decimal(16, 2)
          N'yongjun2x2-anh2.png' , -- image - nvarchar(250)
          N'50mm x 50mm x 50mm' , -- size - nvarchar(50)
          N'Nhựa ABS cao cấp' , -- material - nvarchar(50)
          66.7 , -- weight - decimal(5, 1)
          N'Stickerless ' , -- color - nvarchar(50)
          N'Thiết kế với cấu trúc mới giúp giải nhanh, giải tốc độ (thích hợp trong thi đấu). Tuy nhiên vẫn nên lube lại 1 chút để mang đến cảm giác chân thực nhất' , -- description - nvarchar(300)
          0  -- is_del - bit
        ),
		( 200003 , -- category_id - int
          400004 , -- manufacturer_id - int
          N' YJ YuPo V2 M Stickerless ( Có Nam Châm )' , -- product_name - nvarchar(255)
          100 , -- quantity_in_stock - int
          131000 , -- original_price - decimal(16, 2)
          N'yongjun2x2-anh3.png' , -- image - nvarchar(250)
          N'50mm x 50mm x 50mm' , -- size - nvarchar(50)
          N'Nhựa ABS cao cấp' , -- material - nvarchar(50)
          77 , -- weight - decimal(5, 1)
          N'Stickerless ' , -- color - nvarchar(50)
          N'Bản cải tiến mới của 2x2, được trang bị nam châm giúp kiểm soát tốt hơn, chơi phê hơn. Thiết kế với cấu trúc mới giúp giải nhanh, giải tốc độ (thích hợp trong thi đấu).' , -- description - nvarchar(300)
          0  -- is_del - bit
        ), --4x4 ****
		( 200001 , -- category_id - int
          400004 , -- manufacturer_id - int
          N' Nam Châm YongJun YuSu V2 M Stickerless ( Có Nam Châm )' , -- product_name - nvarchar(255)
          100 , -- quantity_in_stock - int
          297000 , -- original_price - decimal(16, 2)
          N'yongjun4x4-anh1.png' , -- image - nvarchar(250)
          N'61.5mm x 61.5mm x 61.5mm' , -- size - nvarchar(50)
          N'Nhựa ABS cao cấp' , -- material - nvarchar(50)
          157 , -- weight - decimal(5, 1)
          N'Stickerless ' , -- color - nvarchar(50)
          N'Bản YJ V2M 4x4 này được trang bị sẵn nam châm hút khá vừa tay, cảm giác chơi cực kì đã. YJ V2M 4x4 (Có nam châm sẵn) là sản phẩm được khá nhiều cuber trên thế giới ưa chuộng' , -- description - nvarchar(300)
          0  -- is_del - bit
        ),
		( 200001 , -- category_id - int
          400004 , -- manufacturer_id - int
          N' YJ MGC 4x4 Stickerless (Hãng mod Nam châm)' , -- product_name - nvarchar(255)
          100 , -- quantity_in_stock - int
          400000 , -- original_price - decimal(16, 2)
          N'yongjun4x4-anh2.png' , -- image - nvarchar(250)
          N'61mm x 61mm x 61mm' , -- size - nvarchar(50)
          N'Nhựa ABS cao cấp' , -- material - nvarchar(50)
          115 , -- weight - decimal(5, 1)
          N'Stickerless ' , -- color - nvarchar(50)
          N'Chiếc rubik MGC 4 này được trang bị sẵn nam châm hút khá vừa tay, cảm giác chơi cực kì đã. YJ MGC 4x4 M (Có nam châm sẵn) là sản phẩm 4x4 mới nhất trong dòng MGC của YJ' , -- description - nvarchar(300)
          0  -- is_del - bit
        ), -- 5x5 *****
		( 200002 , -- category_id - int
          400004 , -- manufacturer_id - int
          N' YJ MGC 5x5 Có Nam Châm Stickerless (Hãng mod Nam châm)' , -- product_name - nvarchar(255)
          100 , -- quantity_in_stock - int
          500000 , -- original_price - decimal(16, 2)
          N'yongjun5x5-anh1.png' , -- image - nvarchar(250)
          N'62mm x 62mm x 62mm' , -- size - nvarchar(50)
          N'Nhựa ABS cao cấp' , -- material - nvarchar(50)
          136.7 , -- weight - decimal(5, 1)
          N'Stickerless ' , -- color - nvarchar(50)
          N'Chiếc rubik MGC 5 này được trang bị sẵn nam châm hút khá vừa tay, cảm giác chơi cực kì đã YJ MGC 5x5 M (Có nam châm sẵn) là sản phẩm 4x4 mới nhất trong dòng MGC của YJ' , -- description - nvarchar(300)
          0  -- is_del - bit
        );
-- khuyển mãi
INSERT INTO dbo.FlashSale
        ( start_day, end_day, is_status )
VALUES  ( GETDATE(), -- start_day - date
          '2023-08-14', -- end_day - date
          0  -- is_status - bit
          )

-- chi tiết khuyến mãi
INSERT INTO dbo.PromotionalDetails
        ( product_id ,
          flashSale_id ,
          discounted_price ,
          promotion_status
        )
VALUES  ( 300000 , -- product_id - int
          990000 , -- flashSale_id - int
          480000 , -- discounted_price - decimal(16, 2)
          0  -- promotion_status - bit
        ),
		( 300007 , -- product_id - int
          990000 , -- flashSale_id - int
          70000 , -- discounted_price - decimal(16, 2)
          0  -- promotion_status - bit
        ),
		( 300008 , -- product_id - int
          990000 , -- flashSale_id - int
          200000.00 , -- discounted_price - decimal(16, 2)
          0  -- promotion_status - bit
        ),
		( 300018 , -- product_id - int
          990000 , -- flashSale_id - int
          230000.00 , -- discounted_price - decimal(16, 2)
          0  -- promotion_status - bit
        ),
		( 300037 , -- product_id - int
          990000 , -- flashSale_id - int
          80000.00 , -- discounted_price - decimal(16, 2)
          0  -- promotion_status - bit
        ),
		( 300059 , -- product_id - int
          990000 , -- flashSale_id - int
          240000.00 , -- discounted_price - decimal(16, 2)
          0  -- promotion_status - bit
        ),
		( 300052 , -- product_id - int
          990000 , -- flashSale_id - int
          117000.00 , -- discounted_price - decimal(16, 2)
          0  -- promotion_status - bit
        ),
		( 300049 , -- product_id - int
          990000 , -- flashSale_id - int
          100000.00 , -- discounted_price - decimal(16, 2)
          0  -- promotion_status - bit
        );
-- người dùng
INSERT INTO dbo.UserCustom
        ( username ,
          password ,
          email ,
          phone_number ,
          address ,
          isAdmin ,
          is_del ,
          fullname
        )
VALUES  ( N'admin123' , -- username - nvarchar(255)
          N'admin123aA@' , -- password - nvarchar(255)
          N'nguyentcpc04750@fpt.edu.vn' , -- email - nvarchar(255)
          N'0911726601' , -- phone_number - nvarchar(20)
          N'Sóc trăng' , -- address - nvarchar(255)
          1 , -- isAdmin - bit
          0 , -- is_del - bit
          N'Trần Chí Nguyễn'  -- fullname - nvarchar(70)
        ),
		( N'nguoidung1' , -- username - nvarchar(255)
          N'nguoidung1aA@' , -- password - nvarchar(255)
          N'nguoidung1@gmail.com' , -- email - nvarchar(255)
          N'0911726611' , -- phone_number - nvarchar(20)
          N'Cần Thơ' , -- address - nvarchar(255)
          0 , -- isAdmin - bit
          0 , -- is_del - bit
          N'Trần Văn Bé'  -- fullname - nvarchar(70)
        ),
		( N'nguoidung2' , -- username - nvarchar(255)
          N'nguoidung2aA@' , -- password - nvarchar(255)
          N'nguoidung2@gmail.com' , -- email - nvarchar(255)
          N'0911726991' , -- phone_number - nvarchar(20)
          N'Cần Thơ' , -- address - nvarchar(255)
          0 , -- isAdmin - bit
          0 , -- is_del - bit
          N'Trần Văn Lớn'  -- fullname - nvarchar(70)
        ),
		( N'nguoidung3' , -- username - nvarchar(255)
          N'nguoidung3aA@' , -- password - nvarchar(255)
          N'nguoidung3@gmail.com' , -- email - nvarchar(255)
          N'0911906991' , -- phone_number - nvarchar(20)
          N'Cà Mau' , -- address - nvarchar(255)
          0 , -- isAdmin - bit
          0 , -- is_del - bit
          N'Trần Minh Em'  -- fullname - nvarchar(70)
        ),
		( N'nguoidung4' , -- username - nvarchar(255)
          N'nguoidung4aA@' , -- password - nvarchar(255)
          N'nguoidung4@gmail.com' , -- email - nvarchar(255)
          N'091100991' , -- phone_number - nvarchar(20)
          N'Hậu Giang' , -- address - nvarchar(255)
          0 , -- isAdmin - bit
          0 , -- is_del - bit
          N'Nguyễn Minh Khôi'  -- fullname - nvarchar(70)
        ),
		( N'nguoidung5' , -- username - nvarchar(255)
          N'nguoidung5aA@' , -- password - nvarchar(255)
          N'nguoidung5@gmail.com' , -- email - nvarchar(255)
          N'091104591' , -- phone_number - nvarchar(20)
          N'Hậu Giang' , -- address - nvarchar(255)
          0 , -- isAdmin - bit
          0 , -- is_del - bit
          N'Nguyễn Trí Tài'  -- fullname - nvarchar(70)
        ),
		( N'nguoidung6' , -- username - nvarchar(255)
          N'nguoidung6aA@' , -- password - nvarchar(255)
          N'nguoidung6@gmail.com' , -- email - nvarchar(255)
          N'091104001' , -- phone_number - nvarchar(20)
          N'Bạc Liêu' , -- address - nvarchar(255)
          0 , -- isAdmin - bit
          0 , -- is_del - bit
          N'Lê Thị Tuyết'  -- fullname - nvarchar(70)
        ),
		( N'nguoidung7' , -- username - nvarchar(255)
          N'nguoidung7aA@' , -- password - nvarchar(255)
          N'nguoidung7@gmail.com' , -- email - nvarchar(255)
          N'09117791' , -- phone_number - nvarchar(20)
          N'Bến Tre' , -- address - nvarchar(255)
          0 , -- isAdmin - bit
          0 , -- is_del - bit
          N'Bùi Minh Thư'  -- fullname - nvarchar(70)
        ),
		( N'nguoidung8' , -- username - nvarchar(255)
          N'nguoidung8aA@' , -- password - nvarchar(255)
          N'nguoidung8@gmail.com' , -- email - nvarchar(255)
          N'091104588' , -- phone_number - nvarchar(20)
          N'Cần Thơ' , -- address - nvarchar(255)
          0 , -- isAdmin - bit
          0 , -- is_del - bit
          N'Lê Minh Tài Em'  -- fullname - nvarchar(70)
        ),
		( N'nguoidung9' , -- username - nvarchar(255)
          N'nguoidung9aA@' , -- password - nvarchar(255)
          N'nguoidung9@gmail.com' , -- email - nvarchar(255)
          N'091994591' , -- phone_number - nvarchar(20)
          N'Tiền Giang'  , -- address - nvarchar(255)
          0 , -- isAdmin - bit
          0 , -- is_del - bit
          N'Đặng Hữu Nghĩa'  -- fullname - nvarchar(70)
        );
	
-- giỏ hàng
INSERT INTO dbo.Cart
        ( user_id ,
          product_id ,
          quantity ,
          price
        )
VALUES  ( 101012 , -- user_id - int
          300005, -- product_id - int
          1 , -- quantity - int
          459000.00  -- price - decimal(16, 2)
        ),
		( 101012 , -- user_id - int
          300052, -- product_id - int
          2 , -- quantity - int
          157000.00  -- price - decimal(16, 2)
        )
-- PROC
GO 
-- doanh thu theo ngày
CREATE PROCEDURE RevenueByDay
  @date DATE
AS
BEGIN
  SELECT SUM(total_amount) AS revenue
  FROM Invoice
  WHERE invoice_date = @date;
END
GO

-- doanh thu theo tháng
CREATE PROCEDURE RevenueByMonth
  @month INT,
  @year INT
AS
BEGIN
  SELECT SUM(total_amount) AS revenue
  FROM Invoice
  WHERE MONTH(invoice_date) = @month
    AND YEAR(invoice_date) = @year;
END
GO 
EXEC dbo.RevenueByMonth @month = 7, -- int
    @year = 2023 -- int

-- doanh thu theo nam
CREATE PROCEDURE RevenueByYear
  @year INT
AS
BEGIN
  SELECT SUM(total_amount) AS revenue
  FROM Invoice
  WHERE YEAR(invoice_date) = @year;
END
GO 
-- tổng số lượng bán được của từng sản phẩm
CREATE PROCEDURE TotalSoldProductList
AS
BEGIN
  SELECT p.product_id, p.product_name, SUM(id.quantity) AS total_quantity_sold
  FROM Product p
  INNER JOIN InvoiceDetail id ON p.product_id = id.product_id
  INNER JOIN Invoice i ON id.invoice_id = i.invoice_id
  WHERE p.is_del = 0
  GROUP BY p.product_id, p.product_name ORDER BY total_quantity_sold DESC;
END

EXEC dbo.TotalSoldProductList
GO 
-- giảm số lượng hàng trong kho của sản phẩm khi có người mua hàng

CREATE TRIGGER UpdateQuantityInStock
ON InvoiceDetail
AFTER INSERT
AS
BEGIN
  UPDATE Product
  SET quantity_in_stock = quantity_in_stock - i.quantity
  FROM Product p
  INNER JOIN inserted i ON p.product_id = i.product_id;
END
GO 

--Tổng lượt like sanr phẩm 
ALTER PROCEDURE TotalLike
AS 
BEGIN
	SELECT   a.product_id, b.product_name,COUNT(*) AS N'totalLike' FROM dbo.Wishlist a 
	INNER JOIN dbo.Product b
	ON b.product_id = a.product_id
	GROUP BY a.product_id ,b.product_name
	ORDER BY COUNT(*) DESC
END
EXEC dbo.TotalLike
GO 
-- tổng số đơn hàng và tổng tiền của khách hàng 
CREATE PROCEDURE totalInvoice
AS 
BEGIN
	SELECT a.user_id, b.fullname,COUNT(*) AS N'totalInvoice', SUM(a.total_amount) AS N'totalAmount' FROM dbo.Invoice a
	INNER JOIN dbo.UserCustom b 
	ON b.user_id = a.user_id
	GROUP BY  a.user_id, b.fullname
END
EXEC dbo.totalInvoice
GO

-- doanh thu cua hang
CREATE PROCEDURE GetRevenueByTimeRange
  @startDate DATETIME,
  @endDate DATETIME
AS
BEGIN
  SELECT
	
    I.invoice_date,
    SUM(ID.quantity * ID.price) AS total_revenue
  FROM
    Invoice AS I
    INNER JOIN InvoiceDetail AS ID ON I.invoice_id = ID.invoice_id
  WHERE
    I.invoice_date BETWEEN @startDate AND @endDate
  GROUP BY
    I.invoice_date
  ORDER BY
    I.invoice_date;
END;

-- cập nhật flashSale tự động khi thời gian kết thúc = thời gian hiện tại

GO 
CREATE TRIGGER UpdateFlashSaleStatus
ON FlashSale
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @CurrentDateTime DATETIME;
    SET @CurrentDateTime = GETDATE();

    UPDATE fs
    SET fs.is_status = 1
    FROM Inserted i
    JOIN FlashSale fs ON i.flashSale_id = fs.flashSale_id
    WHERE i.is_status = 0 AND i.end_day <= @CurrentDateTime;
END;
GO 
CREATE PROCEDURE UpdateFlashSaleStatusSP
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @CurrentDateTime DATETIME;
    SET @CurrentDateTime = GETDATE();

    UPDATE fs
    SET fs.is_status = 1
    FROM FlashSale fs
    WHERE fs.is_status = 0 AND fs.end_day <= @CurrentDateTime;
END;
EXEC UpdateFlashSaleStatusSP
