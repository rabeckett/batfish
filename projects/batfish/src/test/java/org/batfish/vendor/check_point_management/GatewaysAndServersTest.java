package org.batfish.vendor.check_point_management;

import static org.hamcrest.Matchers.equalTo;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertThat;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.google.common.collect.ImmutableList;
import com.google.common.collect.ImmutableMap;
import com.google.common.testing.EqualsTester;
import org.apache.commons.lang3.SerializationUtils;
import org.batfish.common.util.BatfishObjectMapper;
import org.batfish.datamodel.Ip;
import org.junit.Test;

/** Test of {@link GatewaysAndServers}. */
public final class GatewaysAndServersTest {

  @Test
  public void testCustom() throws JsonProcessingException {
    String input =
        "{                              \"objects\": [                                  {          "
            + "                            \"uid\": \"edad6483-1cdb-5a48-b174-bcb253d3ae30\",      "
            + "                                \"name\": \"cp-mgmt\",                              "
            + "        \"type\": \"CpmiHostCkp\",                                      \"domain\":"
            + " {                                          \"uid\":"
            + " \"41e821a0-3720-11e3-aa6e-0800200c9fde\",                                         "
            + " \"name\": \"SMC User\",                                          \"domain-type\":"
            + " \"domain\"                                      },                                 "
            + "     \"policy\": {},                                      \"operating-system\":"
            + " \"Gaia\",                                      \"hardware\": \"Open server\",      "
            + "                                \"version\": \"R80.40\",                            "
            + "          \"ipv4-address\": \"10.150.0.10\",                                     "
            + " \"interfaces\": [                                          {                       "
            + "                       \"interface-name\": \"eth0\",                                "
            + "              \"ipv4-address\": \"10.2.0.33\",                                      "
            + "        \"ipv4-network-mask\": \"255.255.255.0\",                                   "
            + "           \"ipv4-mask-length\": 24,                                             "
            + " \"dynamic-ip\": false,                                              \"topology\": {"
            + "                                                  \"leads-to-internet\": true       "
            + "                                       }                                          } "
            + "                                     ],                                     "
            + " \"network-security-blades\": {},                                     "
            + " \"management-blades\": {                                         "
            + " \"network-policy-management\": true,                                         "
            + " \"logging-and-status\": true                                      },               "
            + "                       \"sic-status\": \"communicating\",                           "
            + "           \"tags\": [],                                      \"icon\":"
            + " \"NetworkObjects/CheckPoint/Hosts/xHost_CP\",                                     "
            + " \"groups\": [],                                      \"comments\": \"\",           "
            + "                           \"color\": \"black\",                                    "
            + "  \"meta-info\": {                                          \"lock\": \"unlocked\", "
            + "                                         \"validation-state\": \"ok\",              "
            + "                            \"last-modify-time\": {                                 "
            + "             \"posix\": 1629130477098,                                             "
            + " \"iso-8601\": \"2021-08-16T12:14-0400\"                                          },"
            + "                                          \"last-modifier\": \"System\",            "
            + "                              \"creation-time\": {                                  "
            + "            \"posix\": 1621430472850,                                             "
            + " \"iso-8601\": \"2021-05-19T09:21-0400\"                                          },"
            + "                                          \"creator\": \"System\"                   "
            + "                   },                                      \"read-only\": true      "
            + "                            }]}";
    assertThat(
        BatfishObjectMapper.ignoreUnknownMapper().readValue(input, GatewaysAndServers.class),
        equalTo(
            new GatewaysAndServers(
                ImmutableMap.<Uid, GatewayOrServer>builder()
                    .put(
                        Uid.of("0"),
                        new CpmiClusterMember(
                            Ip.ZERO,
                            "foo",
                            ImmutableList.of(),
                            GatewayOrServerPolicy.empty(),
                            Uid.of("0")))
                    .put(
                        Uid.of("1"),
                        new CpmiGatewayCluster(
                            ImmutableList.of("m1"),
                            Ip.ZERO,
                            "foo",
                            ImmutableList.of(),
                            GatewayOrServerPolicy.empty(),
                            Uid.of("1")))
                    .put(
                        Uid.of("2"),
                        new CpmiHostCkp(
                            Ip.ZERO,
                            ImmutableList.of(),
                            "foo",
                            GatewayOrServerPolicy.empty(),
                            Uid.of("2")))
                    .put(
                        Uid.of("3"),
                        new CpmiVsClusterNetobj(
                            ImmutableList.of("m1"),
                            Ip.ZERO,
                            "foo",
                            ImmutableList.of(),
                            GatewayOrServerPolicy.empty(),
                            Uid.of("3")))
                    .put(
                        Uid.of("4"),
                        new CpmiVsNetobj(
                            Ip.ZERO,
                            "foo",
                            ImmutableList.of(),
                            GatewayOrServerPolicy.empty(),
                            Uid.of("4")))
                    .put(
                        Uid.of("5"),
                        new CpmiVsxClusterMember(
                            Ip.ZERO,
                            "foo",
                            ImmutableList.of(),
                            GatewayOrServerPolicy.empty(),
                            Uid.of("5")))
                    .put(
                        Uid.of("6"),
                        new CpmiVsxClusterNetobj(
                            ImmutableList.of("m1"),
                            Ip.ZERO,
                            "foo",
                            ImmutableList.of(),
                            GatewayOrServerPolicy.empty(),
                            Uid.of("6")))
                    .put(
                        Uid.of("7"),
                        new CpmiVsxNetobj(
                            Ip.ZERO,
                            "foo",
                            ImmutableList.of(),
                            GatewayOrServerPolicy.empty(),
                            Uid.of("7")))
                    .put(
                        Uid.of("8"),
                        new SimpleGateway(
                            Ip.ZERO,
                            "foo",
                            ImmutableList.of(),
                            GatewayOrServerPolicy.empty(),
                            Uid.of("8")))
                    .build())));
  }

  @Test
  public void testJacksonDeserialization() throws JsonProcessingException {
    String input =
        "{"
            + "\"GARBAGE\":0,"
            + "\"objects\":["
            + "{" // object: CpmiClusterMember
            + "\"type\":\"CpmiClusterMember\","
            + "\"uid\":\"0\","
            + "\"name\":\"foo\","
            + "\"interfaces\":[],"
            + "\"ipv4-address\":\"0.0.0.0\","
            + "\"policy\": {}"
            + "}," // object: CpmiClusterMember
            + "{" // object: CpmiGatewayCluster
            + "\"type\":\"CpmiGatewayCluster\","
            + "\"uid\":\"1\","
            + "\"name\":\"foo\","
            + "\"interfaces\":[],"
            + "\"ipv4-address\":\"0.0.0.0\","
            + "\"cluster-member-names\":[\"m1\"],"
            + "\"policy\": {}"
            + "}," // object: CpmiGatewayCluster
            + "{" // object: CpmiHostCkp
            + "\"type\":\"CpmiHostCkp\","
            + "\"uid\":\"2\","
            + "\"name\":\"foo\","
            + "\"ipv4-address\":\"0.0.0.0\","
            + "\"interfaces\":[],"
            + "\"policy\": {}"
            + "}," // object: CpmiHostCkp
            + "{" // object: CpmiVsClusterNetobj
            + "\"type\":\"CpmiVsClusterNetobj\","
            + "\"uid\":\"3\","
            + "\"name\":\"foo\","
            + "\"interfaces\":[],"
            + "\"ipv4-address\":\"0.0.0.0\","
            + "\"cluster-member-names\":[\"m1\"],"
            + "\"policy\": {}"
            + "}," // object: CpmiVsClusterNetobj
            + "{" // object: CpmiVsNetobj
            + "\"type\":\"CpmiVsNetobj\","
            + "\"uid\":\"4\","
            + "\"name\":\"foo\","
            + "\"interfaces\":[],"
            + "\"ipv4-address\":\"0.0.0.0\","
            + "\"policy\": {}"
            + "}," // object: CpmiVsNetobj
            + "{" // object: CpmiVsxClusterMember
            + "\"type\":\"CpmiVsxClusterMember\","
            + "\"uid\":\"5\","
            + "\"name\":\"foo\","
            + "\"interfaces\":[],"
            + "\"ipv4-address\":\"0.0.0.0\","
            + "\"policy\": {}"
            + "}," // object: CpmiVsxClusterMember
            + "{" // object: CpmiVsxClusterNetobj
            + "\"type\":\"CpmiVsxClusterNetobj\","
            + "\"uid\":\"6\","
            + "\"name\":\"foo\","
            + "\"interfaces\":[],"
            + "\"ipv4-address\":\"0.0.0.0\","
            + "\"cluster-member-names\":[\"m1\"],"
            + "\"policy\": {}"
            + "}," // object: CpmiVsxClusterNetobj
            + "{" // object: CpmiVsxNetobj
            + "\"type\":\"CpmiVsxNetobj\","
            + "\"uid\":\"7\","
            + "\"name\":\"foo\","
            + "\"interfaces\":[],"
            + "\"ipv4-address\":\"0.0.0.0\","
            + "\"policy\": {}"
            + "}," // object: CpmiVsxNetobj
            + "{" // object: simple-gateway
            + "\"type\":\"simple-gateway\","
            + "\"uid\":\"8\","
            + "\"name\":\"foo\","
            + "\"interfaces\":[],"
            + "\"ipv4-address\":\"0.0.0.0\","
            + "\"policy\": {}"
            + "}" // object: simple-gateway
            + "]" // objects
            + "}"; // GatewaysAndServers
    assertThat(
        BatfishObjectMapper.ignoreUnknownMapper().readValue(input, GatewaysAndServers.class),
        equalTo(
            new GatewaysAndServers(
                ImmutableMap.<Uid, GatewayOrServer>builder()
                    .put(
                        Uid.of("0"),
                        new CpmiClusterMember(
                            Ip.ZERO,
                            "foo",
                            ImmutableList.of(),
                            GatewayOrServerPolicy.empty(),
                            Uid.of("0")))
                    .put(
                        Uid.of("1"),
                        new CpmiGatewayCluster(
                            ImmutableList.of("m1"),
                            Ip.ZERO,
                            "foo",
                            ImmutableList.of(),
                            GatewayOrServerPolicy.empty(),
                            Uid.of("1")))
                    .put(
                        Uid.of("2"),
                        new CpmiHostCkp(
                            Ip.ZERO,
                            ImmutableList.of(),
                            "foo",
                            GatewayOrServerPolicy.empty(),
                            Uid.of("2")))
                    .put(
                        Uid.of("3"),
                        new CpmiVsClusterNetobj(
                            ImmutableList.of("m1"),
                            Ip.ZERO,
                            "foo",
                            ImmutableList.of(),
                            GatewayOrServerPolicy.empty(),
                            Uid.of("3")))
                    .put(
                        Uid.of("4"),
                        new CpmiVsNetobj(
                            Ip.ZERO,
                            "foo",
                            ImmutableList.of(),
                            GatewayOrServerPolicy.empty(),
                            Uid.of("4")))
                    .put(
                        Uid.of("5"),
                        new CpmiVsxClusterMember(
                            Ip.ZERO,
                            "foo",
                            ImmutableList.of(),
                            GatewayOrServerPolicy.empty(),
                            Uid.of("5")))
                    .put(
                        Uid.of("6"),
                        new CpmiVsxClusterNetobj(
                            ImmutableList.of("m1"),
                            Ip.ZERO,
                            "foo",
                            ImmutableList.of(),
                            GatewayOrServerPolicy.empty(),
                            Uid.of("6")))
                    .put(
                        Uid.of("7"),
                        new CpmiVsxNetobj(
                            Ip.ZERO,
                            "foo",
                            ImmutableList.of(),
                            GatewayOrServerPolicy.empty(),
                            Uid.of("7")))
                    .put(
                        Uid.of("8"),
                        new SimpleGateway(
                            Ip.ZERO,
                            "foo",
                            ImmutableList.of(),
                            GatewayOrServerPolicy.empty(),
                            Uid.of("8")))
                    .build())));
  }

  @Test
  public void testJavaSerialization() {
    GatewaysAndServers obj =
        new GatewaysAndServers(
            ImmutableMap.of(
                Uid.of("0"),
                new SimpleGateway(
                    Ip.ZERO,
                    "foo",
                    ImmutableList.of(),
                    GatewayOrServerPolicy.empty(),
                    Uid.of("0"))));
    assertEquals(obj, SerializationUtils.clone(obj));
  }

  @Test
  public void testEquals() {
    GatewaysAndServers obj = new GatewaysAndServers(ImmutableMap.of());
    new EqualsTester()
        .addEqualityGroup(obj, new GatewaysAndServers(ImmutableMap.of()))
        .addEqualityGroup(
            new GatewaysAndServers(
                ImmutableMap.of(
                    Uid.of("0"),
                    new SimpleGateway(
                        Ip.ZERO,
                        "foo",
                        ImmutableList.of(),
                        GatewayOrServerPolicy.empty(),
                        Uid.of("0")))))
        .testEquals();
  }
}
