# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

QueryCode.create([
{category_name: "header_search_clf", category_param_name: "完全一致", category_param_value: 1},
{category_name: "header_search_clf", category_param_name: "前方一致", category_param_value: 2},
{category_name: "header_search_clf", category_param_name: "後方一致", category_param_value: 3},
{category_name: "header_search_clf", category_param_name: "部分一致", category_param_value: 4},
{category_name: "header_search_tgt_clf", category_param_name: "User", category_param_value: 1},
{category_name: "header_search_tgt_clf", category_param_name: "Book", category_param_value: 2}
])

