# 处理Airwallex的行分类
# data structure
# category (code, name, children)
# - code 
# - name
# - children is a list of category
import json
with open("/Users/zhangjing/Downloads/aw_industry_category.json","r") as file:
    ic_data = json.load(file)

with open("/Users/zhangjing/Desktop/OSSU-CS/InTro CS/py4e/script_help/industry_desc.json","r") as file:
    cat_desc_data = json.load(file)

# 分类代码:分类详情字典英文
simplify_json = dict()
# 分类代码:分类详情字典中文
simplify_json_zh = dict()

# 分类代码列表
category_code_list = list()
# 进php配置文件的分类描述字符串列表 “代码” => “描述”
category_desc = list()
# 分类代码=>英文
category_en = dict()
category_zh = dict()
category_lang_dict = dict()
# 分类语言包配置列表   “中文描述” => “英文描述”
category_lang = list()


for category in ic_data["data"]:
    category_code = category["classifications"]["L2"]["contentfulKey"]
    category_code_list.append(category_code)
    parent_code = category["classifications"]["L1"]["contentfulKey"]
    parent_name = category["classifications"]["L1"]["name"]
    temp_children = {"code":category_code,"name":category["classifications"]["L2"]["name"]}
    if simplify_json.get(parent_code) is None:
        simplify_json[parent_code] = {"name":parent_name,"children":list()}
    simplify_json[parent_code]["children"].append(temp_children)
    # 对二级分类通过分类编号排序
    simplify_json[parent_code]["children"].sort(key=lambda x: x["code"])
    category_en[parent_code] = parent_name
    category_en[category_code] = category["classifications"]["L2"]["name"]

# 对分类排序
sorted_dict_by_key = {k: simplify_json[k] for k in sorted(simplify_json)}


cat_desc_data.sort(key=lambda x: x["id"])
for cate_desc in cat_desc_data:
    if  cate_desc["id"] in category_code_list:
        # str = '"' + cate_desc["id"] + '" => "' + cate_desc["label"] + '",\n'
        str = cate_desc["label"] + '\n'
        category_desc.append(str)
        category_zh[cate_desc["id"]] = cate_desc["label"]



# 使用列表推导式和字典推导式从2个字典组成一个新字典or列表
lang_dict = {category_zh[key]: category_en[key] for key in category_zh}
lang_list = [f"\"{key}\" => \"{lang_dict[key]}\",\n" for key in lang_dict]

# print(category_zh)
# exit()
# 将分类详情中文写入文件
for key,value in sorted_dict_by_key.items():
    simplify_json_zh[key] = {
        "name":category_zh.get(key,""),
        "children":[]
    }
    for lv2 in value["children"]:
        child = {"code":lv2["code"],"name":category_zh[lv2["code"]]}
        simplify_json_zh[key]["children"].append(child)
with open("./industry_category_zh.json","w") as file:
    json.dump(simplify_json_zh,file,ensure_ascii=False, indent=4)
exit()
# 将分类描述写入php文件中
# with open("/Users/zhangjing/Desktop/OSSU-CS/InTro CS/py4e/script_help/industry_desc.php","a") as file:
#     file.write("return [\n")
#     file.writelines(category_desc)
#     file.write("];")

# 将分类中英文对应语言写入文件中
# with open("/Users/zhangjing/Desktop/OSSU-CS/InTro CS/py4e/script_help/industry_lang.txt","a") as file:
#     file.writelines(lang_list)
# exit()
# 将分类详情英文写入json文件中
# with open("./industry_category.json","w") as file:
#     json.dump(sorted_dict_by_key,file,ensure_ascii=False, indent=4)
        
