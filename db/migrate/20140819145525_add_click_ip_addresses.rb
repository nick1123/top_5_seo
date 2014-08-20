class AddClickIpAddresses < ActiveRecord::Migration
  def change
    add_column :posts, :click_ip_addresses, :text
  end
end
