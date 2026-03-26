-- 1. Xóa bảng cũ nếu có để làm mới hoàn toàn
DROP TABLE IF EXISTS results;
DROP TABLE IF EXISTS members;
DROP TABLE IF EXISTS app_users;

-- 2. Tạo bảng tài khoản
CREATE TABLE app_users (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  username TEXT UNIQUE NOT NULL,
  password TEXT NOT NULL,
  role TEXT NOT NULL,
  label TEXT NOT NULL,
  team INTEGER DEFAULT 0
);
-- TẮT BẢO MẬT ĐỂ APP ĐỌC ĐƯỢC DỮ LIỆU CÔNG KHAI
ALTER TABLE app_users DISABLE ROW LEVEL SECURITY;

-- 3. Tạo bảng thành viên
CREATE TABLE members (
  code TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  team INTEGER NOT NULL,
  female BOOLEAN DEFAULT false
);
ALTER TABLE members DISABLE ROW LEVEL SECURITY;

-- 4. Tạo bảng kết quả
CREATE TABLE results (
  match_key TEXT PRIMARY KEY,
  s1 INTEGER NOT NULL,
  s2 INTEGER NOT NULL,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now())
);
ALTER TABLE results DISABLE ROW LEVEL SECURITY;

-- 5. Chèn tài khoản Admin
INSERT INTO app_users (username, password, role, label, team)
VALUES ('admin', 'admin123', 'admin', 'Quản trị viên', 0);

-- 6. Chèn dữ liệu mẫu thành viên
INSERT INTO members (code, name, team, female)
VALUES
  ('A1', 'Chị Lệ', 1, true), ('B1', 'A Kaka', 1, false), ('C1', 'A Cao Cường', 1, false),
  ('D1', 'A Tú', 1, false), ('E1', 'A Hiếu', 1, false), ('F1', 'Lĩnh', 1, false), ('G1', 'A Toại', 1, false),
  ('A2', 'C Ng Ngọc', 2, true), ('B2', 'A Hữu Cường', 2, false), ('C2', 'A Tí', 2, false),
  ('D2', 'A Hoàng', 2, false), ('E2', 'A Tuân', 2, false), ('F2', 'Đoàn', 2, false), ('G2', 'Đạt', 2, false),
  ('A3', 'Chị Hà Ngọc', 3, true), ('B3', 'a Trung', 3, false), ('C3', 'a Dũng', 3, false),
  ('D3', 'a Duy', 3, false), ('E3', 'a Thi', 3, false), ('F3', 'Chú Phố', 3, false), ('G3', 'a Quý', 3, false);
