class CreateMicroposts < ActiveRecord::Migration[6.1]
  def change
    create_table :microposts do |t|
      t.text :content
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :microposts, [:user_id, :created_at] # micropostsテーブルのuser_idとcreated_atというカラムにindexを加えることでデータを取り出しやすくしている。
    # 上のようにカラムが二つなので、複合キーインデックスとなっている
  end
end
