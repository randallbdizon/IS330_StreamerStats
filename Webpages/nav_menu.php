<header>
     <?php  
       if(!isset($path_prefix))
       {
           $path_prefix = "";
       }
    ?>
    <nav id="nav_menu">
        <ul>
            <li><a href="<?php echo($path_prefix . "home.php") ?>" class="transition-link" data-transition="./../Media/Images/GreenZoomBack1.gif">Home</a>
            </li>
            <li><a href="<?php echo($path_prefix . "streamers.php") ?>" class="transition-link"
                    data-transition="./../Media/Images/GreenZoomBack1.gif">Streamers</a></li>
            <li><a href="<?php echo($path_prefix . "projects.php") ?>" class="transition-link"
                    data-transition="./../Media/Images/GreenZoomBack1.gif">Projects</a></li>
        </ul>
    </nav>
</header>