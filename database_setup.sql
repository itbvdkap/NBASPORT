-- ==========================================
-- DATABASE SETUP FOR BADMINTON TOURNAMENT
-- ==========================================

-- 1. Bảng thành viên (Players)
CREATE TABLE IF NOT EXISTS members (
  code TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  team INTEGER NOT NULL,
  female BOOLEAN DEFAULT false
);

-- 2. Bảng kết quả trận đấu (Match Results)
CREATE TABLE IF NOT EXISTS results (
  match_key TEXT PRIMARY KEY, -- Định dạng "round-court" (ví dụ: "1-1")
  s1 INTEGER NOT NULL,
  s2 INTEGER NOT NULL,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now())
);

-- 3. Bảng tài khoản người dùng (Authentication)
CREATE TABLE IF NOT EXISTS app_users (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  username TEXT UNIQUE NOT NULL,
  password TEXT NOT NULL,
  role TEXT NOT NULL, -- 'admin', 'ref1', 'ref2', 'ref3', 'viewer'
  label TEXT NOT NULL,
  team INTEGER DEFAULT 0
);

-- 4. Chèn dữ liệu mẫu (Tài khoản mặc định)
-- Lưu ý: Bạn có thể đổi mật khẩu tại đây trước khi chạy
INSERT INTO app_users (username, password, role, label, team)
VALUES 
  ('admin', 'admin123', 'admin', 'Quản trị viên', 0),
  ('trongtai1', '1234', 'ref1', 'Trọng tài Đội 1', 1),
  ('trongtai2', '1234', 'ref2', 'Trọng tài Đội 2', 2),
  ('trongtai3', '1234', 'ref3', 'Trọng tài Đội 3', 3),
  ('xem', '', 'viewer', 'Khán giả', 0)
ON CONFLICT (username) DO NOTHING;

-- 5. Chèn dữ liệu thành viên mặc định (Tùy chọn)
-- App sẽ tự động đẩy lên nếu bảng trống, nhưng bạn có thể chạy thủ công tại đây nếu muốn.
INSERT INTO members (code, name, team, female)
VALUES
  ('A1', 'Chị Lệ', 1, true), ('B1', 'A Kaka', 1, false), ('C1', 'A Cao Cường', 1, false),
  ('D1', 'A Tú', 1, false), ('E1', 'A Hiếu', 1, false), ('F1', 'Lĩnh', 1, false), ('G1', 'A Toại', 1, false),
  ('A2', 'C Ng Ngọc', 2, true), ('B2', 'A Hữu Cường', 2, false), ('C2', 'A Tí', 2, false),
  ('D2', 'A Hoàng', 2, false), ('E2', 'A Tuân', 2, false), ('F2', 'Đoàn', 2, false), ('G2', 'Đạt', 2, false),
  ('A3', 'Chị Hà Ngọc', 3, true), ('B3', 'a Trung', 3, false), ('C3', 'a Dũng', 3, false),
  ('D3', 'a Duy', 3, false), ('E3', 'a Thi', 3, false), ('F3', 'Chú Phố', 3, false), ('G3', 'a Quý', 3, false)
ON CONFLICT (code) DO NOTHING;
