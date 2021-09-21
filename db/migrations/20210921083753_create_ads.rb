Sequel.migration do
  change do
    create_table(:ads) do
      primary_key :id, type: :Bignum

      Bignum :user_id, null: false
      String :title, null: false
      String :description, text: true, null: false
      String :city, null: false
      Float :lat
      Float :lon
      DateTime :created_at, size: 6, null: false
      DateTime :updated_at, size: 6, null: false

      index [:user_id], name: :index_ads_on_user_id
    end
  end
end
