-- =========================================
-- BÁO CÁO "ĐỘ LỆCH HỌC PHÍ"
-- =========================================

/*
YÊU CẦU:
Xuất ra:
1. Tên khóa học
2. Giá khóa học
3. Độ lệch giá so với giá trung bình toàn sàn

Price_Difference =
price - AVG(price của toàn bộ Courses)
*/


-- =========================================
-- 1. GIẢI PHÁP KIẾN TRÚC
-- =========================================

/*
VẤN ĐỀ:
------------------------------------------------

Nếu viết:

SELECT AVG(price)
FROM Courses;

=> Chỉ ra 1 dòng duy nhất.

Nếu GROUP BY:
=> Dữ liệu bị gom nhóm
=> Mất chi tiết từng khóa học.

------------------------------------------------
GIẢI PHÁP:
------------------------------------------------

Dùng Scalar Subquery trong SELECT.

Scalar Subquery:
- Là subquery trả về đúng 1 giá trị
- Có thể được dùng như một "biến toàn cục"

Ví dụ:

(
    SELECT AVG(price)
    FROM Courses
)

=> Trả về đúng 1 con số:
VD: 400000

------------------------------------------------
ĐIỀU KỲ DIỆU:
------------------------------------------------

MySQL sẽ:
- Vẫn duyệt từng dòng Courses
- Nhưng đồng thời nhét thêm
  giá trị trung bình toàn hệ thống
  vào từng dòng.

=> Ta vừa có:
✅ Dữ liệu chi tiết từng course
✅ Góc nhìn tổng quan toàn hệ thống

Mà KHÔNG cần GROUP BY.
*/


-- =========================================
-- 2. CÂU LỆNH SQL HOÀN CHỈNH
-- =========================================

SELECT
    title,
    price,

    price - (
        SELECT AVG(price)
        FROM Courses
    ) AS Price_Difference

FROM Courses;


-- =========================================
-- 3. MINH HỌA KẾT QUẢ
-- =========================================

/*
Giả sử AVG(price) toàn sàn = 400000

Kết quả:

| title      | price  | Price_Difference |
|------------|---------|------------------|
| SQL Basic  | 500000  | +100000          |
| Python Pro | 350000  | -50000           |
| AI Master  | 900000  | +500000          |

------------------------------------------------
Ý nghĩa:
------------------------------------------------

Dương (+):
=> Khóa học đang cao hơn mặt bằng chung

Âm (-):
=> Khóa học đang thấp hơn mặt bằng chung
*/