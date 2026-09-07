-- =========================================================
--  Set akun KNLVX jadi Developer (role tertinggi)
--  Jalankan di Supabase Dashboard > SQL Editor SETELAH akun
--  KNLVX sudah daftar lewat community/signup.html.
--
--  Aman dijalankan berkali-kali (idempotent) — kalau sudah
--  developer, query ini gak ngubah apa-apa lagi.
--
--  Catatan: role 'developer' sengaja gak bisa diangkat lewat
--  panel web (community/developer.html), makanya harus lewat
--  SQL manual kayak gini.
-- =========================================================

update public.profiles
set role = 'developer'
where username = 'KNLVX'
  and role <> 'developer';

-- Cek hasilnya:
select id, username, display_name, role
from public.profiles
where username = 'KNLVX';
