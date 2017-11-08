package info.igreque.keepmecontributinghs;

import org.junit.Test;

import static org.junit.Assert.*;

/**
 * Example local unit test, which will execute on the development machine (host).
 *
 * @see <a href="http://d.android.com/tools/testing">Testing documentation</a>
 */
public class ExampleUnitTest {
    /**
     * NOTE: This test accesses to GitHub API without any mock!
     *       DO NOT run on CI!
     * @throws Exception when test fails.
     */
    @Test
    public void run_eta_main() throws Exception {
        eta.main.main(new String[]{});
    }

    @Test
    public void run_eta_spec() throws Exception {
//        info.igreque.KeepMeContributingWidgetProviderHs.spec();
    }
}