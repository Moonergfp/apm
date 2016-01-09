$(function(){
	var $list=$(".filelist");
	var $btn=$("#ctlBtn");
	var state = 'pending';
	var uploader = WebUploader.create({
    /*server: 'http://webuploader.duapp.com/server/fileupload.php',*/
    pick: '#picker',
	swf:"static/webuploader/Uploader.swf",
    resize: false,
	serve:'./server/fileupload.php'
    });
	uploader.on( 'fileQueued', function( file ) {
		var $new_file="<div class='file'"+"id='"+file.id+"'>"+"<span>"+file.name+"</span>"+"<span class='state'>等待上传....</span>"+"<a class='delete_file'>"+"删除"+"</a>"+"</div>";
		$list.append($new_file);
		$("#ctlBtn").show();
		/*$(".delete_file").on('click',function(){
			$(this).parent().remove();	
			});*/
		$(".delete_file").click(function(){
			var $id=$(this).parent().attr("id");
			uploader.removeFile($id);
			$(this).parent().remove();
			var $lenght=$list.find("div[class='file']").length;
			if($lenght==0){
				$btn.hide(); 
				}
			});
        });
        
   uploader.on( 'uploadProgress', function( file, percentage ) {
         var $li = $( "#"+file.id );
         $percent = $li.find('.progress .progress-bar .load-bar-inner');

         
         if ( !$percent.length ) {
             $percent = $('<div class="progress">' +
              '<div class="progress-bar">' +'<div class="load-bar-inner" data-loading="0">'+
              '</div>' +'</div>').appendTo( $li ).find('.progress-bar .load-bar-inner');
        }

        $("#"+file.id).find("span[class='state']").html('上传中....');

        $percent.css( 'width', percentage * 100 + '%' );
          });
   
   uploader.on( 'uploadSuccess', function( file ) {
        $("#"+file.id).find("span[class='state']").text('上传成功');
       });

    uploader.on( 'uploadError', function( file ) {
        $("#"+file.id).find("span[class='state']").text('上传出错');
    });

    uploader.on( 'uploadComplete', function( file ) {
        $( '#'+file.id ).find('.progress').fadeOut();
    });

    uploader.on( 'all', function( type ) {
        if ( type === 'startUpload' ) {
            state = 'uploading';
        } else if ( type === 'stopUpload' ) {
            state = 'paused';
        } else if ( type === 'uploadFinished' ) {
            state = 'done';
        }

        if ( state === 'uploading' ) {
            $btn.text('暂停上传');
        } else {
            $btn.text('开始上传');
        }
    });

    $btn.on( 'click', function() {
        if ( state === 'uploading' ) {
            uploader.stop();
        } else {
            uploader.upload();
        }
    });
})