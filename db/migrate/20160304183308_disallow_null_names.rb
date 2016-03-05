class DisallowNullNames < ActiveRecord::Migration
  def change
    change_column_null :members, :nickname, false
    change_column_null :members, :government_name, false
  end
end
