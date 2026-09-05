-- =========================================================
--  Migration: Generic file upload support (e.g. Ready Settings .txt)
--  Run this ONCE in Supabase Dashboard > SQL Editor
-- =========================================================

-- 1. Create a public storage bucket for uploaded post files
insert into storage.buckets (id, name, public)
values ('post-files', 'post-files', true)
on conflict (id) do nothing;

-- 2. Storage policies: anyone can view/download files (public bucket),
--    but a user can only upload/update/delete files inside their
--    OWN folder (named after their user id) within the bucket.

create policy "post_files_public_read"
on storage.objects for select
using (bucket_id = 'post-files');

create policy "post_files_insert_own"
on storage.objects for insert
with check (
  bucket_id = 'post-files'
  and (storage.foldername(name))[1] = auth.uid()::text
);

create policy "post_files_update_own"
on storage.objects for update
using (
  bucket_id = 'post-files'
  and (storage.foldername(name))[1] = auth.uid()::text
);

create policy "post_files_delete_own"
on storage.objects for delete
using (
  bucket_id = 'post-files'
  and (storage.foldername(name))[1] = auth.uid()::text
);
