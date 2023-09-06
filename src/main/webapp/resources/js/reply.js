console.log("Reply Module....");

var replyService = (function () {
  function add(reply, callback, error) {
    console.log("add reply........");
    $.ajax({
      type: "post",
      url: "/replies/new",
      data: JSON.stringify(reply),
      contentType: "application/json; charset=utf-8",
      success: function (result, status, xhr) {
        if (callback) {
          callback(result);
        }
      },
      error: function (xhr, status, er) {
        if (error) {
          error(er);
        }
      },
    });
  }

  function getList(param, callback, error) {
    var prdctno = param.prdctno;
    var page = param.page || 1;
    $.getJSON(
      "/replies/pages/" + prdctno + "/" + page + ".json",
      function (data) {
        if (callback) {
          callback(data);
        }
      }
    ).fail(function (xhr, status, err) {
      if (error) {
        error();
      }
    });
  }

  function show(rno, callback, error) {
    $.getJSON("/replies/show/" + rno + ".json", function (data) {
      console.log(data);
      if (callback) {
        callback(data);
      }
    }).fail(function (xhr, status, err) {
      console.log(data);

      if (error) {
        error(err);
      }
    });
  }

  return {
    add: add,
    getList: getList,
    show: show,
  };
})();
