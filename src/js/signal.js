
function _Signal(){
  var list = this.list = [], one=[];
  /**
   *  On: listen to list
   */
  this.one = function(func){
    var self = this;
    this.bind(func);
    one.push(func);
  }

  this.bind = function(func){
    var i = list.length;
    while(i--){
        if(func == list[i])return; 
    }
    list.push(func)
  }
  /**
   *  Off: stop listening to event / specific callback
   */
  this.unbind = function(func){
    if(!func){
        list = []
        return
    }
    var i = list.length;
    while(i--) func == list[i] && list.splice(i,1)
  }
  /** 
   * Emit: send event, callbacks will be triggered
   */
  this.send = function(){
    var i = 0, j;
    while(j=list[i++]) j.apply(this,arguments)
    i = one.length;
    while(i--){
        this.unbind(one[i])
    }
    one = [] 
  };
};

window.Signal = function (){
    return new _Signal()
}
