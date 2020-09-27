import processing.core.PApplet;
float[] values;
Algorithms algs = new Algorithms();

public class Algorithms {

  public void selectionSort() {
    for (int i = 0; i < values.length -1; i++) {
      int smallIndex = i;
      for(int j = i; j <values.length; j++) {
        if (values[smallIndex] > values[j]) {
          smallIndex = j;
        }
      }
      swap(smallIndex,i);
    } 
  }
  
  
  public void bubbleSort() {
    for (int i = 0; i < values.length - 1; i++) {
      for (int j = 0; j < values.length-i-1; j++) {
        float a = values[j];
        float b = values[j+1];
        if (a > b) {
          swap(j, j+1);
        }
      }
    }
  }


  public void mergeSort(int left, int right) {
    if(left < right ) {
      int mid = (left + right) / 2;
      //recursively merges starting with the smallest possible arrays
      mergeSort(left, mid);
      mergeSort(mid+1, right);
      //merge both arrays
      merge(left, mid, right);   
    }
    
  }
   
  private void merge(int left, int mid, int right) {
     //creates temp variables for the starting positions
     int r = left;
     int s = mid+1;
     float result[] = new float[right-left+1];
     int k=0;
      
     for(int i = left ; i <= right ; i++) {
       //checks whether left ends
       if(r > mid) 
         result[k++] = values[s++];
       //checks whether right ends
       else if (s > right)   
         result[k++] = values[r++];
       //checks which part's element is smaller
       else if (values[r] < values[s])     
         result[k++] = values[r++];
       else
         result[k++] = values[s++];
      }
      
      //the result array is now sorted
      for (int v=0 ; v< k; v++) {
        values[left++] = result[v] ;      
        try{Thread.sleep(10);}catch(Exception e){}; //delay to show visualization
        redraw();
     }
  }
  
  private void swap(int a, int b) {
    float temp = values[a];
    values[a] = values[b];
    values[b] = temp;
    try{Thread.sleep(10);} catch(Exception e){}; //delay to show visualization
    redraw();
  }

  private int partition(int left, int right) {
    //just make the starting pivot index the leftmost index
    int pivotIndex = left;
    float pivot = values[right];
    for (int i =left; i < right; i++) {
      if (values[i] < pivot) {
        //pushes smaller value to left of pivot
        swap(i, pivotIndex++);
      }
    }
    //pushes greater value to right of pivot
    swap(pivotIndex, right);
    return pivotIndex;
  }

  public void quickSort(int left, int right) {
    if (left < right) {
      int pivot = partition(left, right);
      quickSort(left, pivot - 1);
      quickSort(pivot + 1, right);
    }
  }
  
}


//MOST IMPORTANT PART OF PROGRAM
//UNCOMMENT THE ALGORITHM YOU WISH TO RUN

Thread t = new Thread(){
  public void run() {
    //algs.selectionSort();
    //algs.bubbleSort();
    algs.mergeSort(0,values.length-1);
    //algs.quickSort(0,values.length-1);
  }
};


void setup() {
  size(800,600);
  values = new float[width];
  //initializes the values array with random sizes in the dimensions of the window
  for (int i = 0; i < values.length; i++) {
    values[i] = random(height);
  }
  //starts running the thread created above to start showing the sorting process
  t.start();
}


void draw() {
  background(0);
  //draws the values in the array
  for (int i = 0; i < values.length; i++) {
      stroke(0,255,255);
      line(i, height, i, height - values[i]);
    }  
}
