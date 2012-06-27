
/*
   Author shaoyang
   email:yushaoyang@WindRoader.com
   @createddate 2012-06-27 21:44:59 +0800
*/


(function() {
  var $,TemplateCLient,TemplateClientAction,TemplateClientListAction,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  $ = jQuery;

   
  /*Template Model<Spine.Model*/
  TemplateClient = (function(_super) {

    __extends(TemplateClient, _super);

    function TemplateClient() {
      this.url = __bind(this.url, this);
      return TemplateClient.__super__.constructor.apply(this, arguments);
    }

    TemplateClient.configure("TemplateClient", "name", "content", "tid");

    TemplateClient.extend(Spine.Model.Ajax);

    TemplateClient.prototype.url = function() {
      return "/protovis/service";
    };

    TemplateClient.url = function() {
      return "/protovis/service";
    };

    return TemplateClient;

  }).call(this, Spine.Model);
  
  /*Template item controller<Spine.Controller*/
  TemplateClientAction = (function(_super) {

    __extends(TemplateClientAction, _super);

    TemplateClientAction.extend(Spine.Events);

    function TemplateClientAction() {
      this.render = __bind(this.render, this);
      TemplateClientAction.__super__.constructor.apply(this, arguments);
      this.item.bind("update", this.render);
      this.item.bind("destroy", this.release);
      this.Class = this.constructor;
      this.initialize();
    }

    TemplateClientAction.initialize = function() {};

    TemplateClientAction.loadtemp = function() {
      TemplateClientAction.temp = $(".TemplateActionView");
      TemplateClientAction.include(TemplateActionScript);
    };

    TemplateClientAction.loadtemp();

    TemplateClientAction.prototype.render = function() {
      this.replace($(this.Class.temp).tmpl(this.item));
      return this;
    };


    

    return TemplateClientAction;

  }).call(this, Spine.Controller);

  /*Template List controller<Spine.Controller*/
   TemplateClientListAction = (function(_super) {

    __extends(TemplateClientListAction, _super);

    function TemplateClientListAction() {
      this.addAll = __bind(this.addAll, this);

      this.addOne = __bind(this.addOne, this);

      this.render = __bind(this.render, this);
      TemplateClientListAction.__super__.constructor.apply(this, arguments);
      TemplateClient.bind("create", this.addOne);
      TemplateClient.bind("refresh", this.addAll);
      this.Class = this.constructor;
      this.initialize();
      this.render();
      TemplateClient.fetch();
    }

    TemplateClientListAction.prototype.initialize = function() {};

    TemplateClientListAction.loadtemp = function() {
      TemplateClientListAction.temp = $(".TemplateListActionView");
      TemplateClientListAction.include(TemplateListActionScript);
    };

    TemplateClientListAction.loadtemp();

    TemplateClientListAction.prototype.render = function() {
      this.replace($(this.Class.temp).tmpl());
      return this;
    };

    TemplateClientListAction.prototype.addOne = function(TemplateClient) {
      var view;
      this.TemplateClient = TemplateClient;
      view = new TemplateClientAction({
        item: TemplateClient
      });
      return this.items.append(view.render().el);
    };

    TemplateClientListAction.prototype.addAll = function() {
      return TemplateClient.each(this.addOne);
    };

    return TemplateClientListAction;

  }).call(this, Spine.Controller);


  $(function(){
       return new TemplateClientListAction({
      el: $("#templates")
    });
  })
  
}).call(this);
