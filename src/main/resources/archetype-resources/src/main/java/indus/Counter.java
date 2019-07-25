#set( $symbol_pound = '#' )
#set( $symbol_dollar = '$' )
#set( $symbol_escape = '\' )
/**
 * ${robotName} generated free by NoraUi Organization https://github.com/NoraUi
 * ${robotName} is licensed under the license BSD.
 * CAUTION: ${robotName} use NoraUi library. This project is licensed under the license GNU AFFERO GENERAL PUBLIC LICENSE
 *
 * @author Nicolas HALLOUIN
 * @author Stéphane GRILLON
 */
package ${package}.indus;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;     

import ${package}.utils.${robotName}Context;
import com.github.noraui.exception.TechnicalException;
import com.github.noraui.indus.MavenRunCounter;
import com.github.noraui.utils.Context;

public class Counter {
    
    /**
     * Specific LOGGER
     */
    private static final Logger LOGGER = LoggerFactory.getLogger(Counter.class);

    public static void main(String[] args) {
        List<String> manager = new ArrayList<>();

        List<String> scenarioBlacklist = new ArrayList<>();
        // you can add not run scenario here
        // scenarioBlacklist.add("---  you can add not run scenario here ---");

        List<String> versionControlSystemsBlacklist = new ArrayList<>();
        versionControlSystemsBlacklist.add(".svn");

        ${robotName}Context.getInstance().initializeEnv("${robotName}.properties");

        MavenRunCounter mavenRunCounter = new MavenRunCounter();
        try {
            List<MavenRunCounter.Counter> counters = mavenRunCounter.count(versionControlSystemsBlacklist, scenarioBlacklist, manager, new File(Context.getResourcesPath() + "/steps"));
            mavenRunCounter.print(counters, args[0]);
        } catch (TechnicalException e) {
            LOGGER.error("TechnicalException error: ", e);
        }
    }

}
