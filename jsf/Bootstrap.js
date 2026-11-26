var smallWidth=480;

function bootSize(parentWidth,column)
{
    var screensize=getScreenSize(parentWidth);

    //=========================================
    var colsize=12;
    var colums=  column.split(" ");
    for(var i =0;i<colums.length;i++ )
    {
        var sp=colums[i].split("-");
        if(sp[0]===screensize)
        {
            colsize=sp[1];
            break;
        }
    }
    //===============================

    if(colsize==12)
    {
        return parentWidth;
    }
    else if(colsize==11)
    {
        return (parentWidth*91.66666667)/100;
    }
    else if(colsize==10)
    {
        return (parentWidth*83.33)/100;
    }
    else if(colsize==9)
    {
        return (parentWidth*75)/100;
    }
    else if(colsize==8)
    {
        return (parentWidth*66.66)/100;
    }
    else if(colsize==7)
    {
        return (parentWidth*58.33)/100;
    }
    else if(colsize==6)
    {
        return (parentWidth*50)/100;
    }
    else if(colsize==5)
    {
        return (parentWidth*41.66)/100;
    }
    else if(colsize==4)
    {
        return (parentWidth*33.33)/100;
    }
    else if(colsize==3)
    {
        return (parentWidth*25)/100;
    }
    else if(colsize==2)
    {
        return (parentWidth*16.66)/100;
    }
    else if(colsize==1)
    {
        return (parentWidth*8.33)/100;
    }
}

function getScreenSize(width)
{
    if(width<=544)
    {
        return "xs";
    }
    else if(width<=768)
    {
        return "sm";
    }
    else if(width<=992)
    {
        return "md";
    }
    else if(width<=1200)
    {
        return "lg";
    }
    else if(width>1200)
    {
        return "xl";
    }
}
function getColumnSize(columnString,screenSize){
    var colsize=12;
    var colums= columnString.split(" ");
    for(var i =0;i<colums.length;i++ )
    {
        var sp=colums[i].split("-");
        if(sp[0]===screenSize)
        {
            colsize=sp[1];
            break;
        }
    }
    return colsize;
}
function bootFontSize(parentWidth,columnsSize)
{
    var screensize=getScreenSize(parentWidth);
    //========================================
    return getColumnSize(columnsSize,screensize);
}
function openWindow(qmlFile)
{
    var component = Qt.createComponent(qmlFile)
    var window    = component.createObject(root)

    window.show();
}
var component;
function createWindow(name,parentName)
{
    var n=name;
    if(!n.includes(".qml"))
    {
        n=n+".qml";
    }
    component= Qt.createComponent(n);
    if(component.status===Component.Ready)
    {
        return component.createObject(parentName);
    }
    else if(component.status===Component.Error)
    {
        console.log(component.errorString());
    }
}
