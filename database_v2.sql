-- 1. Bảng định nghĩa cặp đôi (Pairs)
CREATE TABLE pairs (
  id TEXT PRIMARY KEY, -- vd: AB1, AC2...
  codes TEXT[] NOT NULL, -- mảng chứa mã vđv: ['A1', 'B1']
  team INTEGER NOT NULL
);
ALTER TABLE pairs DISABLE ROW LEVEL SECURITY;

-- 2. Bảng lịch thi đấu (Schedule)
CREATE TABLE schedule (
  id SERIAL PRIMARY KEY,
  round INTEGER NOT NULL,
  court INTEGER NOT NULL,
  pair1_id TEXT REFERENCES pairs(id),
  pair2_id TEXT REFERENCES pairs(id), -- có thể null nếu nghỉ
  ref_team INTEGER NOT NULL,
  is_live BOOLEAN DEFAULT false
);
ALTER TABLE schedule DISABLE ROW LEVEL SECURITY;

-- 3. Bảng nhật ký (Audit Logs)
CREATE TABLE audit_logs (
  id SERIAL PRIMARY KEY,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
  username TEXT,
  match_key TEXT,
  action TEXT, -- 'UPDATE', 'RESET'
  details JSONB
);
ALTER TABLE audit_logs DISABLE ROW LEVEL SECURITY;

-- DỮ LIỆU MẪU CHO PAIRS (Ví dụ cho Đội 1)
INSERT INTO pairs (id, codes, team) VALUES 
('AB1', ARRAY['A1','B1'], 1), ('AC1', ARRAY['A1','C1'], 1), ('AD1', ARRAY['A1','D1'], 1),
('AB2', ARRAY['A2','B2'], 2), ('AC2', ARRAY['A2','C2'], 2), ('AD2', ARRAY['A2','D2'], 2),
('AB3', ARRAY['A3','B3'], 3), ('AC3', ARRAY['A3','C3'], 3), ('AD3', ARRAY['A3','D3'], 3);

-- DỮ LIỆU MẪU CHO SCHEDULE (Lượt 1)
INSERT INTO schedule (round, court, pair1_id, pair2_id, ref_team) VALUES 
(1, 1, 'AB1', 'AB2', 3),
(1, 2, 'AC1', 'AC3', 2),
(1, 3, 'AD2', 'AD3', 1);
