# SSMMemberOperation
会员管理系统
功能点：
 1、分页
 2、数据校验： jquery前端校验+JSR303后端校验
 3、ajax
 4、Rest风格的URI；使用HTTP协议请求方式的动词，来表示对资源的操作（GET（查询），POST（新增），PUT（修改），DELETE（删除））

技术点：
• 基础框架-ssm（SpringMVC+Spring+MyBatis）
• 数据库-MySQL
• 前端框架-bootstrap快速搭建简洁美观的界面
• 项目的依赖管理-Maven
• 分页-pagehelper
• 逆向工程-MyBatis Generator

• URI：
1./emps  初始查询
2./emp/{id} GET 查询员工
3./emp POST 保存员工
4./emp/{id} PUT 修改员工
5./emp/{id} DELETE 删除员工
