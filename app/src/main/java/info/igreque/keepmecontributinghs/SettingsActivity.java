package info.igreque.keepmecontributinghs;


import info.igreque.android.ActivityImpl;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;

// So far, it's a code just copied from http://eta-lang.org/docs/html/eta-tutorials.html#interacting-with-java
public class SettingsActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        ActivityImpl.startActivity(this);
    }
}
