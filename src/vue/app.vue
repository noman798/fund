script
    module.exports = {
        el:"#app"
        data:function(){
            return {
                name:"guowenfh",
                age:"2q1"
            }
		}
    }

template
    div
    	h1 姓名：{{name}}
        h2 {{age}}

style lang="sass"
    $qwe:#098;
    body{
        background-color: $qwe;
        h1{
            background-color: #eee;
            color: red;
            transform: translate(10%, 10%);/*测试自动添加前缀*/
        }
        h1:hover{
            height:100px;
        }
        h2{
            background-color: #999;
        }
    }
