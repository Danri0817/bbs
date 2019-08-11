<?php
	session_start();
	require('dbconnect.php');

	if (isset($_SESSION['id']) && $_SESSION['time'] + 3600 > time()){
		$_SESSION['time'] = time();

		$members = $db->prepare('SELECT * FROM members WHERE id=?');
		$members ->execute(array($_SESSION['id']));

		$member = $members->fetch();
	}else{
		header('Location: login.php');
		exit();
	}

	if (!empty($_POST)){

		$fileName = $_FILES['image']['name'];
		if (!empty($fileName)){
			$ext = substr($fileName, -3);
			if ($ext != 'jpg' && $ext != 'gif' && $ext != 'png'){
				$error['image'] = 'type';

			}
		}

		if ($_POST['message'] !== '' ){

			if (strlen($_POST['message']) > 140){
				$error['message'] = 'length';
			}else {
				if(!empty($fileName)){
					if (empty($error)){
						$image = date('YmdHis') . $_FILES['image']['name'];
						move_uploaded_file($_FILES['image']['tmp_name'], 'member_picture/'. $image);
						$_POST['image'] = $image;

						$message = $db->prepare('INSERT INTO posts SET member_id=?, message=?, reply_message_id=?, picture=?, created=NOW()');
						$message->execute(array(
							$member['id'],
							$_POST['message'],
							$_POST['reply_post_id'],
							$_POST['image']
						));

						header('Location: index.php');
						exit();
					}
				}else{
					$message = $db->prepare('INSERT INTO posts SET member_id=?, message=?, reply_message_id=?, created=NOW()');
					$message->execute(array(
						$member['id'],
						$_POST['message'],
						$_POST['reply_post_id']
					));

					header('Location: index.php');
					exit();
				}
			}

		}elseif(!empty($fileName)){

			if (empty($error)){
				$image = date('YmdHis') . $_FILES['image']['name'];
				move_uploaded_file($_FILES['image']['tmp_name'], 'member_picture/'. $image);
				$_POST['image'] = $image;

				$message = $db->prepare('INSERT INTO posts SET member_id=?, message=?, reply_message_id=?, picture=?, created=NOW()');
				$message->execute(array(
					$member['id'],
					$_POST['message'],
					$_POST['reply_post_id'],
					$_POST['image']
				));

				header('Location: index.php');
				exit();
			}
		 }
	}

	$page = $_REQUEST['page'];
	if ($page == ''){
		$page = 1;
	}
	$page = max($page, 1);

	$counts = $db->query('SELECT COUNT(*) AS cnt FROM posts');
	$cnt = $counts->fetch();
	$maxPage = ceil($cnt['cnt'] / 5);
	$page = min($page, $maxPage);

	$start = ($page - 1) * 5;

	$posts = $db->prepare('SELECT m.name,p.* FROM members m, posts p WHERE m.id=p.member_id ORDER BY p.created DESC LIMIT ?,5');
	$posts->bindParam(1, $start, PDO::PARAM_INT);
	$posts->execute();


if (isset($_REQUEST['res'])){
	$response = $db->prepare('SELECT m.name, p.* FROM members m, posts p WHERE m.id=p.member_id AND p.id=?');

	$response->execute(array($_REQUEST['res']));

	$table = $response->fetch();
	$message = '@' . $table['name'] . ' ' . $table['message'];

}
?>



<!DOCTYPE html>
<html lang="ja">
<head>
	<meta charset="UTF-8"
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta http-equiv="X-UA-Compatible" content="ie=edge">
	<title>ひとこと掲示板</title>

	<link rel="stylesheet" href="style.css" />
</head>

<body>
<div id="wrap">
  <div id="head">
    <h1>ひとこと掲示板</h1>
  </div>
  <div id="content">
  	<div style="text-align: right"><a href="logout.php">ログアウト</a></div>
    <form action="" method="post" enctype="multipart/form-data">
      <dl>
        <dt><?php print(htmlspecialchars($member['name'], ENT_QUOTES)) ?>さん、メッセージをどうぞ</dt>
				<dt>写真</dt>
				<dd>
		      <input type="file" name="image" size="35" value="test"  />
					<?php if ($error['image'] === 'type'): ?>
		  			<p class="error">*写真などは「.gif」または、「.jpg」「.png」の画像を指定してください</p>
					<?php endif; ?>
					<?php if (!empty($error)): ?>
						<p class="error">*恐れ入りますが、画像を改めて指定してください</p>
					<?php endif; ?>
		    </dd>
        <dd>
					<p style="color: red;">*140文字を超えてはいけません</p>
          <textarea name="message" cols="50" rows="5"><?php print(htmlspecialchars($message, ENT_QUOTES)); ?></textarea>
					<?php if ($error['message'] === 'length'): ?>
		  			<p class="error">*140文字を超えています</p>
					<?php endif; ?>
          <input type="hidden" name="reply_post_id" value="<?php print(htmlspecialchars($_REQUEST['res'], ENT_QUOTES)); ?>" />
        </dd>
      </dl>
      <div>
        <p>
          <input type="submit" value="投稿する" />
        </p>
      </div>
    </form>

	<?php foreach ($posts as $post): ?>
		<div class="msg">
			<?php if ($post['picture']): ?>
	    	<img src="member_picture/<?php print(htmlspecialchars($post['picture'], ENT_QUOTES)); ?>" width="48" height="48"  />
			<?php endif ?>
			<p>
				<?php print(htmlspecialchars($post['message'], ENT_QUOTES)); ?>
				<span class="name">
					（<?php print(htmlspecialchars($post['name'], ENT_QUOTES)); ?>）
				</span>
				[<a href="index.php?res=<?php print(htmlspecialchars($post['id'], ENT_QUOTES)); ?>">Re</a>]
			</p>
	    <p class="day"><a href="view.php?id=<?php print(htmlspecialchars($post['id'], ENT_QUOTES)); ?>"><?php print(htmlspecialchars($post['created'], ENT_QUOTES)); ?></a>
			<?php if($post['reply_message_id'] > 0): ?>
				<a href="view.php?id=<?php print(htmlspecialchars($post['reply_message_id'], ENT_QUOTES)); ?>">
				返信元のメッセージ</a>
			<?php endif; ?>
			<?php if ($_SESSION['id'] == $post['member_id']): ?>
				[<a href="delete.php?id=<?php print(htmlspecialchars($post['id'], ENT_QUOTES)); ?>"
				style="color: #F33;">削除</a>]
			<?php endif; ?>
	    </p>
	  </div>
	<?php endforeach; ?>


<ul class="paging">
	<?php if($page > 1): ?>
	  <li><a href="index.php?page=<?php print($page - 1); ?>">前のページへ</a></li>
	<?php else: ?>
	  <li>前のページへ</li>
	<?php endif; ?>
	<?php if($page < $maxPage): ?>
	  <li><a href="index.php?page=<?php print($page + 1); ?>">次のページへ</a></li>
	<?php else: ?>
	  <li>次のページへ</li>
	<?php endif; ?>
</ul>
  </div>
</div>
</body>
</html>
